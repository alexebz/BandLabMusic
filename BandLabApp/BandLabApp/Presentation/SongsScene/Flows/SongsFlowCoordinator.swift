//
//  SongsFlowCoordinator.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import UIKit

protocol SongsFlowCoordinatorDependencies  {

}

final class SongsFlowCoordinator {

    private weak var navigationController: UINavigationController?
    private let dependencies: SongsFlowCoordinatorDependencies

    init(navigationController: UINavigationController, dependencies: SongsFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
//        let actions = MoviesListViewModelActions(showMovieDetails: showMovieDetails,
//                                                 showMovieQueriesSuggestions: showMovieQueriesSuggestions,
//                                                 closeMovieQueriesSuggestions: closeMovieQueriesSuggestions)
//        let vc = dependencies.makeMoviesListViewController(actions: actions)
//
//        navigationController?.pushViewController(vc, animated: false)
//        moviesListVC = vc
    }
}
