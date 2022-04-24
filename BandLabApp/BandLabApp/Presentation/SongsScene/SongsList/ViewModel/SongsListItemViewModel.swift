//
//  SongsListItemViewModel.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import Foundation

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
    
    private var observation: NSKeyValueObservation?
    private var audioData: Data?
    
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
            playAudio()
        case .Playing:
            pauseAudio()
        case .Paused:
            resumePlaying()
        }
    }
    
    private func loadAudio() {
        audioItemState.value = .Loading(0.0)
        
        let task = audioRepository.downloadSong(with: self.audioURL, completion: { [weak self] result in
            guard let self = self else { return }
            if case let .success(data) = result {
                print(data)
                self.audioData = data
                self.observation?.invalidate()
                self.audioItemState.value = .ReadyToPlay
            }
        })
        observation = task?.progressKVO?.observe(\.fractionCompleted) { [weak self] progress, _ in
            guard let self = self else { return }
            self.audioItemState.value = .Loading(progress.fractionCompleted)
            print("progress: ", progress.fractionCompleted)
        }
    }
    
    private func playAudio() {
        audioItemState.value = .Playing
    }
    
    private func pauseAudio() {
        audioItemState.value = .Paused
    }
    
    private func resumePlaying() {
        audioItemState.value = .Playing
    }

}
