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
    }
    
    @IBAction func actionButtonPressed() {
        self.viewModel.peformStateAction()
    }
}
