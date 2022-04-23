//
//  SongsResponseDTO+Mapping.swift
//  BandLabApp
//
//  Created by l.vasilyeva on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import Foundation

// MARK: - Data Transfer Object
struct SongsResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case songs = "data"
    }
    let songs: [SongDTO]
}

extension SongsResponseDTO {
    struct SongDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case title = "name"
            case audioURL
        }
        let id: String?
        let title: String?
        let audioURL: String?
    }
}

// MARK: - Mappings to Domain
extension SongsResponseDTO {
    func toDomain() -> Songs {
        return .init(songs: songs.map { $0.toDomain() })
    }
}

extension SongsResponseDTO.SongDTO {
    func toDomain() -> Song {
        return .init(id: id,
                     title: title,
                     audioURL: audioURL)
    }
}

