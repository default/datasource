//
//  TableViewSectionDataSource.swift
//  Fitingo
//
//  Created by admin on 30.11.2020.
//  Copyright © 2020 Fitingo. All rights reserved.
//

import UIKit

protocol TableViewSectionDataSource {
    var numberOfItems: Int { get }
    func cellProvider(at indexPath: IndexPath) -> TableViewCellProvider?
}
