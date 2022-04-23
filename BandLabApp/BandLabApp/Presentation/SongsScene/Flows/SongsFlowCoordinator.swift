//
//  SongsFlowCoordinator.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import UIKit

protocol SongsFlowCoordinatorDependencies  {
    func makeSongsListViewController(actions: SongsListViewModelActions) -> SongsListViewController
}

final class SongsFlowCoordinator {

    private weak var navigationController: UINavigationController?
    private let dependencies: SongsFlowCoordinatorDependencies

    private weak var songsListVC: SongsListViewController?

    init(navigationController: UINavigationController, dependencies: SongsFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let actions = SongsListViewModelActions()
        let vc = dependencies.makeSongsListViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
        songsListVC = vc
    }
}
