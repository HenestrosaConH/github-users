//
//  SearchView.swift
//  GitHubUsers
//
//  Created by HenestrosaConH on 2/3/23.
//

import UIKit

class SearchView: UIView {
    
    // MARK: Private Properties
    
    private weak var delegate: SearchDelegate?

    private let logoIv = UIImageView()
    private let usernameTf = GFTextField(
        placeholder: "Search.placeholder".localized()
    )
    private let versionLb = GFSecondaryTitleLabel(fontSize: 14)
    private let getUserBt = GFButton(
        color: .systemGreen,
        title: "Search.get_user".localized(),
        image: SFSymbol.followers.image
    )
    
    private let padding: CGFloat = 50
    
    // MARK: - Initializers
    
    init(delegate: SearchDelegate) {
        super.init(frame: .zero)
        
        self.delegate = delegate
        
        // background color will change depending on the device's theme (light/dark)
        backgroundColor = .systemBackground
        
        configureLogoIv()
        configureUsernameTf()
        configureVersionLb()
        configureGetUserBt()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureLogoIv() {
        addSubview(logoIv)
        
        // Not necessary to do for `usernameTf` and `getUserBt` because the value of the property
        // is already changed in the initializer of their respective classes.
        logoIv.translatesAutoresizingMaskIntoConstraints = false
        logoIv.image = GFImages.ghLogo.image
        
        let size: CGFloat = 200
        
        NSLayoutConstraint.activate([
            logoIv.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 80),
            logoIv.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoIv.heightAnchor.constraint(equalToConstant: size),
            logoIv.widthAnchor.constraint(equalToConstant: size),
        ])
    }
    
    private func configureUsernameTf() {
        addSubview(usernameTf)
        usernameTf.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTf.topAnchor.constraint(equalTo: logoIv.bottomAnchor, constant: 48),
            usernameTf.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameTf.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameTf.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func configureVersionLb() {
        addSubview(versionLb)
        versionLb.text = "v\(Bundle.main.appVersion) (\(Bundle.main.appBuild))"
        
        NSLayoutConstraint.activate([
            versionLb.topAnchor.constraint(equalTo: usernameTf.bottomAnchor, constant: 10),
            versionLb.centerXAnchor.constraint(equalTo: centerXAnchor),
            versionLb.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func configureGetUserBt() {
        addSubview(getUserBt)
        getUserBt.addTarget(self, action: #selector(searchUser), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            getUserBt.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            getUserBt.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            getUserBt.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            getUserBt.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc private func searchUser() {
        delegate?.searchUser(with: usernameTf.text)
    }
    
    // MARK: Public Methods
    
    func resignUsernameTfFirstResponder() {
        usernameTf.resignFirstResponder()
    }
}

// MARK: - Delegates

extension SearchView: UITextFieldDelegate {
    
    // Gets called when the user presses 'Done' on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchUser()
        return true
    }
    
}

extension SearchView: KeyboardDismissable {
    
    func createDismissKeyboardTapGesture() {
        // `UIView.endEditing` means that the first view that's going to intercept the
        // tap event (in our case, the `TextField`) will stop editing. This hides the
        // keyboard when tapping outside the keyboard and the `TextField`.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        addGestureRecognizer(tap)
    }
    
}
