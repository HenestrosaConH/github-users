//
//  GFBaseItemInfoCardVC.swift
//  GitHubUsers
//
//  Created by JC on 26/7/22.
//

import UIKit

class GFItemInfoCardVC: GFBaseCardVC {

    // MARK: - Internal Properties
    
    internal let stackView = UIStackView()
    internal let itemLeft: GFBaseItem
    internal let itemRight: GFBaseItem
    
    
    // MARK: - Initializers
    
    init(itemLeft: GFBaseItem, itemRight: GFBaseItem) {
        self.itemLeft = itemLeft
        self.itemRight = itemRight
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStackView()
    }
    
    
    // MARK: - Private Methods
    
    
     private func configureStackView() {
         view.addSubview(stackView)
         
         stackView.translatesAutoresizingMaskIntoConstraints = false
         
         stackView.axis = .horizontal
         stackView.distribution = .equalSpacing // like space-between in CSS
         
         stackView.addArrangedSubview(itemLeft)
         stackView.addArrangedSubview(itemRight)
         
         NSLayoutConstraint.activate([
             stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
             stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
             stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
             stackView.heightAnchor.constraint(equalToConstant: 50),
         ])
     }

}
