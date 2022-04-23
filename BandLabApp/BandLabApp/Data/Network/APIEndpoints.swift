//
//  APIEndpoints.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import Foundation

struct APIEndpoints {
    
    static func getSongs() -> Endpoint<SongsResponseDTO> {
        return Endpoint(path: "Lenhador/a0cf9ef19cd816332435316a2369bc00/raw/a1338834fc60f7513402a569af09ffa302a26b63/Songs.json",
                        method: .get)
    }

}
