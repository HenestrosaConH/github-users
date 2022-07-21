//
//  GFBaseCardVC.swift
//  GitHubFollowers
//
//  Created by JC on 3/7/22.
//

import UIKit

/**
 Superclass of all GFCards
 */
class GFBaseCardVC: UIViewController {

    internal let stackView = UIStackView()
    internal let itemLeft = GFItemInfoView()
    internal let itemRight = GFItemInfoView()
    internal let actionBt = GFButton()
    
    private let padding: CGFloat = 20
    
    internal var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackground()
        configureStackView()
        configureActionBt()
    }
    
    // Overriden by subclasses
    @objc func actionBtTapped() {}
    
    private func configureBackground() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
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
    
    private func configureActionBt() {
        view.addSubview(actionBt)
        
        actionBt.addTarget(self, action: #selector(actionBtTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionBt.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionBt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionBt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionBt.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
}
