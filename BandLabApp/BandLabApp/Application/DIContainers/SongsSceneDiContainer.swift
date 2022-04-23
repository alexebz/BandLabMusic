//
//  SongsSceneDiContainer.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import UIKit

final class SongsSceneDIContainer {

    // MARK: - Flow Coordinators
    func makeSongsFlowCoordinator(navigationController: UINavigationController) -> SongsFlowCoordinator {
        return SongsFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}


