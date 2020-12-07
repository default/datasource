//
//  CollectionViewCellConfiguration.swift
//  Fitingo
//
//  Created by admin on 30.11.2020.
//  Copyright © 2020 Fitingo. All rights reserved.
//

import UIKit

protocol CollectionViewCellConfiguration: CollectionViewCellProvider {
    associatedtype CellType: UICollectionViewCell, Configurable
    /// Information, used to identify data presented by this cell.
    associatedtype Identity
    
    var viewModel: CellType.Model { get }
    /// Information, used to identify data presented by this cell.
    ///
    /// Use this field to associate any additional information
    /// (i.e. corresponding model), if needed.
    var identity: Identity? { get set }
    
    init(viewModel: CellType.Model)
}
extension CollectionViewCellConfiguration {
    func configuredCell(in collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = CellType.className
        
        collectionView.register(
            CellType.self,
            forCellWithReuseIdentifier: cellId
        )
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellId,
            for: indexPath
        ) as! CellType
        
        cell.configure(model: viewModel)
        return cell
    }
}
