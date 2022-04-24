//
//  RepositoryTask.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import Foundation

protocol NetworkTrackable: Cancellable, Trackable {}

class RepositoryTask: NetworkTrackable {
    var progressKVO: Progress? {
        return networkTask?.progressKVO
    }
    
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
