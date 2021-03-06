//
//  SongsListItemViewModel.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import Foundation
import AVFoundation

enum AudioItemState: Equatable {
    case Initial
    case Loading(Double)
    case ReadyToPlay
    case Playing
    case Paused
}

protocol SongsListItemViewModelDelegate {
    func songStartedPlaying()
}

protocol SongsListItemViewModelInput {
    func peformStateAction()
    func pauseAudio()
}

protocol SongsListItemViewModelOutput {
    var audioItemState: Observable<AudioItemState> { get }
}

final class SongsListItemViewModel: SongsListItemViewModelOutput {
    
    var audioItemState: Observable<AudioItemState> = Observable(.Initial)
    var delegate: SongsListItemViewModelDelegate?
    
    
    let title: String
    let audioURL: String
    
    let audioRepository: AudioRepository
    
    private var audioPlayer: AVAudioPlayer?
    private var observation: NSKeyValueObservation?
    
    init(song: Song, audioRepository: AudioRepository) {
        self.title = song.title ?? ""
        self.audioURL = song.audioURL ?? ""
        self.audioRepository = audioRepository
    }
}

extension SongsListItemViewModel: SongsListItemViewModelInput {
    func peformStateAction() {
        switch audioItemState.value {
        case .Initial:
            loadAudio()
        case .Loading(_):
            break
        case .ReadyToPlay:
            guard let audioPlayer = audioPlayer else {
                print("no audioPlayer to playAudio")
                return
            }
            playAudio(audioPlayer)
        case .Playing:
            guard let audioPlayer = audioPlayer else {
                print("no audioPlayer to resumePlaying")
                return
            }
            pauseAudio(audioPlayer)
        case .Paused:
            guard let audioPlayer = audioPlayer else {
                print("no audioPlayer to pauseAudio")
                return
            }
            resumePlaying(audioPlayer)
        }
    }
    
    private func loadAudio() {
        audioItemState.value = .Loading(0.0)
        
        let task = audioRepository.downloadSong(with: self.audioURL, completion: { [weak self] result in
            guard let self = self else { return }
            if case let .success(data) = result {
                print("Song data loaded: \(data)")
                self.observation?.invalidate()
                do {
                    try self.audioPlayer = AVAudioPlayer(data: data)
                    self.audioItemState.value = .ReadyToPlay
                } catch {
                    self.audioItemState.value = .Initial
                    print("error convertig audio data from \(self.audioURL)")
                }
        
            }
        })
        observation = task?.progressKVO?.observe(\.fractionCompleted) { [weak self] progress, _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.audioItemState.value = .Loading(progress.fractionCompleted)
            }
        }
    }
    
    private func playAudio(_ player: AVAudioPlayer) {
        delegate?.songStartedPlaying()
        player.prepareToPlay()
        player.play()
        audioItemState.value = .Playing
    }
    
    internal func pauseAudio() {
        guard let player = self.audioPlayer else { return }
        guard audioItemState.value == AudioItemState.Playing else { return }
        self.pauseAudio(player)
    }
    
    private func pauseAudio(_ player: AVAudioPlayer) {
        player.pause()
        audioItemState.value = .Paused
    }
    
    private func resumePlaying(_ player: AVAudioPlayer) {
        player.play()
        delegate?.songStartedPlaying()
        audioItemState.value = .Playing
    }

}




