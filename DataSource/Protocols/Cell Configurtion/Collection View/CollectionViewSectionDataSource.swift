//
//  CollectionViewSectionDataSource.swift
//  Fitingo
//
//  Created by admin on 30.11.2020.
//  Copyright © 2020 Fitingo. All rights reserved.
//

import Foundation

protocol CollectionViewSectionDataSource {
    var numberOfItems: Int { get }
    func cellProvider(at index: Int) -> CollectionViewCellProvider?
}
