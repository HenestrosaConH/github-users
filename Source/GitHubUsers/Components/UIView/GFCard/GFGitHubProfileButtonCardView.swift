//
//  GFGitHubProfileCardView.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 26/7/22.
//

import UIKit

protocol GFGitHubProfileCardViewDelegate: AnyObject {
    func didTapGitHubProfile(for url: URL)
}

class GFGitHubProfileCardView: GFBaseCardView {
    
    // MARK: Private Properties
    
    private let actionBt: GFButton
    private let url: URL
    private weak var delegate: GFGitHubProfileCardViewDelegate!
    
    
    // MARK: - Initializers
    
    init(actionBt: GFButton, url: URL, delegate: GFGitHubProfileCardViewDelegate) {
        self.actionBt = actionBt
        self.url = url
        
        super.init()
        self.delegate = delegate
        configureActionBt()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods

    @objc func didTapGitHubProfile() {
        delegate.didTapGitHubProfile(for: url)
    }
    
    // MARK: Private Methods

    private func configureActionBt() {
        addSubview(actionBt)
        
        actionBt.addTarget(self, action: #selector(didTapGitHubProfile), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionBt.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            actionBt.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            actionBt.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            actionBt.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])
    }

}
