//
//  CollectionViewCellProvider.swift
//  Fitingo
//
//  Created by admin on 30.11.2020.
//  Copyright © 2020 Fitingo. All rights reserved.
//

import UIKit

protocol CollectionViewCellProvider {
    func configuredCell(in collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell
}
