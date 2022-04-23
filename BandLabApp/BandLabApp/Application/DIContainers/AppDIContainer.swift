//
//  AppDIContainer.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import Foundation

final class AppDIContainer {
    lazy var appConfiguration = AppConfiguration()

    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!)

        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()

    // MARK: - DIContainers of scenes
    func makeSongsSceneDIContainer() -> SongsSceneDIContainer {
        let dependencies = SongsSceneDIContainer.Dependencies(apiDataTransferService: apiDataTransferService,
                                                               imageDataTransferService: imageDataTransferService)
        return SongsSceneDIContainer(dependencies: dependencies)
    }
}
