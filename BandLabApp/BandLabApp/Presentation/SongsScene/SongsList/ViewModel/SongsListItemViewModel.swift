//
//  SongsListItemViewModel.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import Foundation
import AVFoundation

enum AudioItemState {
    case Initial
    case Loading(Double)
    case ReadyToPlay
    case Playing
    case Paused
}

protocol SongsListItemViewModelInput {
    func peformStateAction()
}

protocol SongsListItemViewModelOutput {
    var audioItemState: Observable<AudioItemState> { get }
}

final class SongsListItemViewModel: SongsListItemViewModelOutput {
    
    var audioItemState: Observable<AudioItemState> = Observable(.Initial)
    
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
                print(data)
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
            self.audioItemState.value = .Loading(progress.fractionCompleted)
        }
    }
    
    private func playAudio(_ player: AVAudioPlayer) {
        player.prepareToPlay()
        player.play()
        audioItemState.value = .Playing
    }
    
    private func pauseAudio(_ player: AVAudioPlayer) {
        player.pause()
        audioItemState.value = .Paused
    }
    
    private func resumePlaying(_ player: AVAudioPlayer) {
        player.play()
        audioItemState.value = .Playing
    }

}




