//
//  SongsListTableViewController.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import UIKit

final class SongsListTableViewController: UITableViewController {

    var viewModel: SongsListViewModel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func reload() {
        tableView.reloadData()
    }

    // MARK: - Private

    private func setupViews() {
        tableView.estimatedRowHeight = SongsListItemCell.height
//        tableView.rowHeight = UITableView.automaticDimension
    }
}
