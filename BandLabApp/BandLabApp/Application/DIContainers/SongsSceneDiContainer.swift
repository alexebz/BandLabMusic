//
//  SongsSceneDiContainer.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import UIKit

final class SongsSceneDIContainer: SongsFlowCoordinatorDependencies {

    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let songDataTransferService: DataTransferService
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Flow Coordinators
    func makeSongsFlowCoordinator(navigationController: UINavigationController) -> SongsFlowCoordinator {
        return SongsFlowCoordinator(navigationController: navigationController, dependencies: self)
    }

    // MARK: - Songs List
    func makeSongsListViewController(actions: SongsListViewModelActions) -> SongsListViewController {
        return SongsListViewController.create(with: makeSongsListViewModel(actions: actions))
    }

    func makeSongsListViewModel(actions: SongsListViewModelActions) -> SongsListViewModel {
        return DefaultSongsListViewModel()
//        return DefaultSongsListViewModel(actions: actions)
    }
}


