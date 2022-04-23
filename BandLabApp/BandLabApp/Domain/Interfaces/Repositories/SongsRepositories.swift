//
//  SongsRepositories.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import Foundation

protocol SongsRepository {
    @discardableResult
    func fetchSongsList(completion: @escaping (Result<Songs, Error>) -> Void) -> Cancellable?
}
