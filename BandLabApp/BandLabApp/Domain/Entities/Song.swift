//
//  Song.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import Foundation

struct Song: Equatable {
    let id: String?
    let title: String?
    let audioURL: String?
}

// For future possible pagination
struct Songs: Equatable {
    let songs: [Song]
}
