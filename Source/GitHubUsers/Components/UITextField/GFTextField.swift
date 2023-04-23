//
//  GFTextField.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 26/6/22.
//

import UIKit

class GFTextField: UITextField {

    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // Won't get called because this initialiser only gets executed if an
    // instance of the view is used in a storyboard scene.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        set(placeholder: placeholder)
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        #if DEBUG
            text = "HenestrosaConH"
        #endif
        
        textColor = .label
        tintColor = .label // blinking cursor
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true // adjusts the font size of the textfield's text
        minimumFontSize = 12 // sets the minimum font size for adjustingFontSizeToFitWidth
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no // no autocorrection for the text field
        returnKeyType = .go // changes the behaviour of the return key of the keyboard
        
        // shows an "X" at the end of the TextField to allow the user to remove the content
        clearButtonMode = .always
        
        // If set to true, the system automatically creates a set of constraints based on
        // the view’s frame and its autoresizing mask.
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func set(placeholder: String) {
        self.placeholder = placeholder
    }
    
}
