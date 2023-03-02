//
//  GFBaseCardVC.swift
//  GitHubUsers
//
//  Created by JC on 3/7/22.
//

import UIKit

/**
 Superclass of all GFCards
 */
class GFBaseCardVC: UIViewController {
    
    internal let padding: CGFloat = 15
    //internal let padding: CGFloat = 20
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackground()
    }
    
    
    private func configureBackground() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
}
