//
//  SongsListItemViewModel.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import Foundation

struct SongsListItemViewModel: Equatable {
    let title: String
}

extension SongsListItemViewModel {

    init(song: Song) {
        self.title = song.title ?? ""
    }
}
