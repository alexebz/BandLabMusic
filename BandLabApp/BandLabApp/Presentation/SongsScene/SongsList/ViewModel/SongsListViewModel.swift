//
//  SongsListViewModel.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import Foundation

struct SongsListViewModelActions {
    /// Note: Possible actions for flow coordinator
}

protocol SongsListViewModel: SongsListViewModelInput, SongsListViewModelOutput {}

protocol SongsListViewModelInput {
    func viewDidLoad()
}

protocol SongsListViewModelOutput {
    var items: Observable<[SongsListItemViewModel]> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var errorTitle: String { get }
}

final class DefaultSongsListViewModel: SongsListViewModel {
    
    private let songRepository: SongsRepository
    
    private var songsLoadTask: Cancellable? { willSet { songsLoadTask?.cancel() } }
    
    // MARK: - OUTPUT
    var items: Observable<[SongsListItemViewModel]> = Observable([])

    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Songs", comment: "")
    let error: Observable<String> = Observable("")
    let errorTitle = NSLocalizedString("Error", comment: "")
    
    // MARK: - Init
    init(songRepository: SongsRepository) {
        self.songRepository = songRepository
    }
    
    // MARK: - Private
    private func load() {
        songsLoadTask = songRepository.fetchSongsList(completion: { result in
            switch result {
            case .success(let songs):
                self.updateSongs(songs)
            case .failure(let error):
                self.handle(error: error)
            }
    })
    }
    
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading songs", comment: "")
    }
    
    private func updateSongs(_ songs: Songs) {
        items.value = songs.songs.map(SongsListItemViewModel.init)
    }

}

// MARK: - INPUT. View event methods
extension DefaultSongsListViewModel {
    func viewDidLoad() {
        load()
    }
}
