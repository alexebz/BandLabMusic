//
//  NetworkConfig.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import Foundation

public protocol NetworkConfigurable {
    var baseURL: URL { get }
}

public struct ApiDataNetworkConfig: NetworkConfigurable {
    public let baseURL: URL

    public init(baseURL: URL) {
        self.baseURL = baseURL
    }
}
