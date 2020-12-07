//
//  TableViewCellConfiguration.swift
//  Fitingo
//
//  Created by admin on 30.11.2020.
//  Copyright © 2020 Fitingo. All rights reserved.
//

import UIKit

// MARK: - CollectionViewProtocol
protocol ListViewProtocol: UIScrollView {
    associatedtype Cell: ListViewCellProtocol
    
    func register<CellType: UIView>(cellClass: CellType.Type)
    func getInstance<CellType: UIView>(of cellClass: CellType.Type, at indexPath: IndexPath) -> CellType
    func make<CellType: UIView>(cell cellType: CellType.Type, at indexPath: IndexPath) -> CellType
}
extension ListViewProtocol {
    func make<CellType: UIView>(cell cellType: CellType.Type, at indexPath: IndexPath) -> CellType {
        register(cellClass: cellType)
        return getInstance(of: cellType, at: indexPath)
    }
}

extension UICollectionView: ListViewProtocol {
    typealias Cell = UICollectionViewCell
    
    func register<CellType>(cellClass: CellType.Type) where CellType : UIView {
        register(cellClass, forCellWithReuseIdentifier: cellClass.className)
    }
    func getInstance<CellType>(of cellClass: CellType.Type, at indexPath: IndexPath) -> CellType where CellType : UIView {
        dequeueReusableCell(withReuseIdentifier: cellClass.className, for: indexPath) as! CellType
    }
}
extension UITableView: ListViewProtocol {
    typealias Cell = UITableViewCell
    
    func register<CellType>(cellClass: CellType.Type) where CellType : UIView {
        register(cellClass, forCellReuseIdentifier: cellClass.className)
    }
    func getInstance<CellType>(of cellClass: CellType.Type, at indexPath: IndexPath) -> CellType where CellType : UIView {
        dequeueReusableCell(withIdentifier: cellClass.className, for: indexPath) as! CellType
    }
}

// MARK: - CollectionViewCellProtocol
protocol ListViewCellProtocol: UIView { }

extension UICollectionViewCell: ListViewCellProtocol { }
extension UITableViewCell: ListViewCellProtocol { }

// MARK: CollectionViewCellProviding
protocol ListViewCellProviding {
    func configuredCell<
        CollectionView: ListViewProtocol,
        CellType
    >(
        for collectionView: CollectionView,
        at indexPath: IndexPath
    ) -> CellType where CollectionView.Cell == CellType
}


// MARK: - CollectionViewCellConfiguring
protocol ListViewCellConfiguring: ListViewCellProviding {
    // MARK: Subtypes
    associatedtype CellType: ListViewCellProtocol, Configurable
    associatedtype Identity
    
    typealias ViewModel = CellType.Model
    
    // MARK: Properties
    var viewModel: ViewModel { get }
    var identity: Identity? { get set }
    
    // MARK: Initializers
    init(viewModel: ViewModel)
}
extension ListViewCellConfiguring {
    func configuredCell<
        CollectionView: ListViewProtocol,
        ProducedCellType
    >(
        for collectionView: CollectionView,
        at indexPath: IndexPath
    ) -> ProducedCellType where CollectionView.Cell == ProducedCellType {
        let cell = collectionView.make(cell: CellType.self, at: indexPath)
        cell.configure(model: viewModel)
        return cell as! ProducedCellType  // A necessary evil
    }
}

protocol ListViewSectionProviding {
    var numberOfItems: Int { get }
    func cellProvider(at index: Int) -> ListViewCellProviding
}

protocol ListViewDataSourcing {
    var numberOfSections: Int { get }
    func numberOfItems(in section: Int) -> Int
    func cellProvider(at indexPath: IndexPath) -> ListViewCellProviding
}

class CollectionView: UIView {
    let view = UICollectionView()
    let dataSource: ListViewDataSourcing
    
    // MARK: Initializers
    init(dataSource: ListViewDataSourcing) {
        self.dataSource = dataSource
        super.init(frame: .zero)
    }
    required init?(coder: NSCoder) {
        fatalError("No.")
    }
    
    // MARK: UICollectionViewDataSource conformance
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource.numberOfSections
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.numberOfItems(in: section)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        dataSource.cellProvider(at: indexPath).configuredCell(for: collectionView, at: indexPath)
    }
}



class TableView: UIView {
    let view = UITableView()
    let dataSource: ListViewDataSourcing
    
    // MARK: Initializers
    init(dataSource: ListViewDataSourcing) {
        self.dataSource = dataSource
        super.init(frame: .zero)
    }
    required init?(coder: NSCoder) {
        fatalError("No.")
    }
}










// MARK: - TableViewCellConfiguration
protocol TableViewCellConfiguration: TableViewCellProvider {
    associatedtype CellType: UITableViewCell, Configurable
    associatedtype Identity
    
    var viewModel: CellType.Model { get }
    var identity: Identity? { get set }
    
    init(viewModel: CellType.Model)
}
extension TableViewCellConfiguration {
    func configuredCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cellId = CellType.className
        
        tableView.register(
            CellType.self,
            forCellReuseIdentifier: cellId
        )
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellId
        ) as! CellType
        
        cell.configure(model: viewModel)
        return cell
    }
}
