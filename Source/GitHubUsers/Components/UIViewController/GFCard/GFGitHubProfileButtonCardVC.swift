//
//  GFButtonCardVC.swift
//  GitHubUsers
//
//  Created by JC on 26/7/22.
//

import UIKit

protocol GFGitHubProfileButtonCardVCDelegate: AnyObject {
    func didTapGitHubProfile(for url: URL)
}

class GFGitHubProfileButtonCardVC: GFBaseCardVC {
    
    // MARK: - Private Properties
    
    private let actionBt: GFButton
    private let url: URL
    private weak var delegate: GFGitHubProfileButtonCardVCDelegate!
    
    
    // MARK: - Initializers
    
    init(actionBt: GFButton, url: URL, delegate: GFGitHubProfileButtonCardVCDelegate) {
        self.actionBt = actionBt
        self.url = url
        
        super.init()
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureActionBt()
    }
    
    
    // MARK: - Public Methods

    @objc func didTapGitHubProfile() {
        delegate.didTapGitHubProfile(for: url)
    }
    
    
    // MARK: - Private Methods

    private func configureActionBt() {
        view.addSubview(actionBt)
        
        actionBt.addTarget(self, action: #selector(didTapGitHubProfile), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionBt.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            actionBt.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionBt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionBt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
    }

}
