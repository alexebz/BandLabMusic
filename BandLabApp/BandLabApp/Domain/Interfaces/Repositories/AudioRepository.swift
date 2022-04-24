//
//  AudioRepository.swift
//  BandLabApp
//
//  Created by Alex on 24.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//
import Foundation

protocol AudioRepository {
    @discardableResult
    func downloadSong(with path: String, completion: @escaping (Result<Data, Error>) -> Void) -> NetworkTrackable? 
}

