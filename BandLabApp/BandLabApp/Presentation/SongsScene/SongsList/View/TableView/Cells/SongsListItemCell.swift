//
//  SongsListItemCell.swift
//  BandLabApp
//
//  Created by Alex on 23.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import UIKit

final class SongsListItemCell: UITableViewCell {
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var backgroundContainer: UIView!
    
    static let reuseIdentifier = String(describing: SongsListItemCell.self)
    static let height = CGFloat(130)
    
    private var viewModel: SongsListItemViewModel!
    
    func fill(with viewModel: SongsListItemViewModel) {
        self.viewModel = viewModel
        songTitle.text = viewModel.title
        bind(to: self.viewModel)
        setupView()
    }
    
    private func setupView() {
        actionButton.imageView?.layer.cornerRadius = actionButton.bounds.height / 2.0
        backgroundContainer.layer.cornerRadius = 10.0
    }
    
    private func bind(to viewModel: SongsListItemViewModel) {
        viewModel.audioItemState.observe(on: self) { [weak self] _ in self?.stateUpdated() }
    }
    
    private func unbind(from viewModel: SongsListItemViewModel) {
        viewModel.audioItemState.remove(observer: self)
    }
    
    private func stateUpdated() {
        switch viewModel.audioItemState.value {
        case .Initial:
            actionButton.setImage(UIImage(named: "download-icon"), for: .normal)
            break
        case .Loading(_):
            break
        case .ReadyToPlay:
            actionButton.setImage(UIImage(named: "play-icon"), for: .normal)
            break
        case .Playing:
            actionButton.setImage(UIImage(named: "pause-icon"), for: .normal)
            break
        case .Paused:
            actionButton.setImage(UIImage(named: "play-icon"), for: .normal)
            break
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        unbind(from: self.viewModel)
    }
    
    @IBAction func actionButtonPressed() {
        self.viewModel.peformStateAction()
    }
}
