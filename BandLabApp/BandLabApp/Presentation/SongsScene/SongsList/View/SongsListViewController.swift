//
//  SongsListViewController.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import UIKit

final class SongsListViewController: UIViewController, StoryboardInstantiable, Alertable {

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
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: SongsListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems() }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == String(describing: SongsListTableViewController.self),
            let destinationVC = segue.destination as? SongsListTableViewController {
            songsTableViewController = destinationVC
            songsTableViewController?.viewModel = viewModel
        }
    }
    
    // MARK: - Private
    private func updateItems() {
        songsTableViewController?.reload()
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: viewModel.errorTitle, message: error)
    }
}
