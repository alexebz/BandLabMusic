//
//  AppFlowCoordinator.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer

    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let songsSceneDIContainer = appDIContainer.makeSongsSceneDIContainer()
        let flow = songsSceneDIContainer.makeSongsFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
