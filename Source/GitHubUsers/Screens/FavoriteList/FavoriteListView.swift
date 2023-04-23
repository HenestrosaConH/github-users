//
//  FavoriteListView.swift
//  GitHubUsers
//
//  Created by JC on 5/3/23.
//

import UIKit

class FavoriteListView: UIView {
    
    // MARK: Properties
    
    private weak var delegate: FavoriteListDelegate?
    private(set) var dataSource: FavoriteListDataSource!
    
    private lazy var tableView = UITableView()

    // MARK: - Initializers
    
    init(delegate: FavoriteListDelegate, dataSource: FavoriteListDataSource) {
        super.init(frame: UIScreen.main.bounds)
        
        self.delegate = delegate
        self.dataSource = dataSource
        
        backgroundColor = .systemBackground
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func reloadData() {
        dataSource.reloadData(tableView)
    }
    
    // MARK: Private Methods
    
    private func configureTableView() {
        addSubview(tableView)
        
        tableView.frame = bounds
        tableView.rowHeight = 80
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        tableView.register(GFFavoriteCell.self, forCellReuseIdentifier: GFFavoriteCell.reuseId)
    }
    
}

extension FavoriteListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRow(at: indexPath.row)
    }
    
    // Hides the empty cells from the TableView
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView(frame: .zero)
    }
    
}
