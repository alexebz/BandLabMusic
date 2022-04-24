//
//  Trackable.swift
//  BandLabApp
//
//  Created by l.vasilyeva on 24.04.2022.
//  Copyright © 2022 AlexeyVasilyev. All rights reserved.
//

import Foundation

public protocol Trackable {
    var progressKVO: Progress? { get }
}
