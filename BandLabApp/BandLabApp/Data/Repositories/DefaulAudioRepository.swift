//
//  DefaulAudioRepository.swift
//  BandLabApp
//
//  Created by Alex on 24.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import Foundation

final class DefaultAudioRepository {
    
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultAudioRepository: AudioRepository {
    
    func downloadSong(with path: String, completion: @escaping (Result<Data, Error>) -> Void) -> NetworkTrackable? {
        let endpoint = APIEndpoints.downloadSong(path: path)
        let task = RepositoryTask()
        task.networkTask = dataTransferService.request(with: endpoint, completion: { (result: Result<Data, DataTransferError>) in
            let result = result.mapError { $0 as Error }
            DispatchQueue.main.async { completion(result) }
        })
    
        return task
    }
}
