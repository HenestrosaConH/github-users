//
//  GFSecondaryTitleLabel.swift
//  GitHubUsers
//
//  Created by JC on 3/7/22.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    
    // MARK: - Private Methods
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        
        // Uses ellipsis for titles if they don't fit in one line.
        lineBreakMode = .byTruncatingTail
        
        translatesAutoresizingMaskIntoConstraints = false
    }

}
