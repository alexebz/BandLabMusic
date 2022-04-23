//
//  SongsListViewController.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import UIKit

final class SongsListViewController: UIViewController, StoryboardInstantiable {

    private var viewModel: SongsListViewModel!

    private var songsTableViewController: SongsListTableViewController?

    // MARK: - Lifecycle
    static func create(with viewModel: SongsListViewModel) -> SongsListViewController {
        let view = SongsListViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Private
}
