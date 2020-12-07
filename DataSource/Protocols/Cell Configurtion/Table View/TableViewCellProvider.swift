//
//  TableViewCellProvider.swift
//  Fitingo
//
//  Created by admin on 30.11.2020.
//  Copyright © 2020 Fitingo. All rights reserved.
//

import UIKit

protocol TableViewCellProvider {
    func configuredCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}

