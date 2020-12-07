//
//  Configurable.swift
//  DataSource
//
//  Created by Nikita Mikheev on 03.12.2020.
//

import Foundation

protocol Configurable {
    associatedtype Model
    func configure(model: Model)
}
