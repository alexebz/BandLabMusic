//
//  DefaultSongsRepository.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import Foundation

final class DefaultSongsRepository {

    private let dataTransferService: DataTransferService
//    private let cache: SongsResponseStorage

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
//        self.cache = cache
    }
}

extension DefaultSongsRepository: SongsRepository {

    public func fetchSongsList(completion: @escaping (Result<Songs, Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        
        let endpoint = APIEndpoints.getSongs()
        task.networkTask = self.dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        return task
    }
}
