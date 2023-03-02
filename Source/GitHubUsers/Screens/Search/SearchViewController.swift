//
//  SearchViewController.swift
//  GitHubUsers
//
//  Created by JC on 21/6/22.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Private Properties
    
    private let logoIv = UIImageView()
    private let usernameTf = GFTextField(
        placeholder: "SearchViewController.placeholder".localized()
    )
    private let versionLb = GFSecondaryTitleLabel(fontSize: 14)
    private let getUserBt = GFButton(
        color: .systemGreen,
        title: "SearchViewController.get_user".localized(),
        image: SFSymbol.followers.image
    )
    
    private let padding: CGFloat = 50
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureLogoIv()
        configureUsernameTf()
        configureVersionLb()
        configuregetUserBt()
        
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*
         We change the value of setNavigationBarHidden in viewWillAppear
         because viewDidLoad gets called only once, so if we go back to
         this ViewController from another ViewController, the navigation
         bar will be visible.
         */
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    // MARK: - Private Methods
    
    private func configureViewController() {
        // background color will change depending on the device theme (light/dark)
        view.backgroundColor = .systemBackground
    }
    
    private func configureLogoIv() {
        view.addSubview(logoIv)
        
        /*
         Not necessary to do for usernameTf and getUserBt because
         the value of the property is already changed in the
         initializer of their respective classes.
         */
        logoIv.translatesAutoresizingMaskIntoConstraints = false
        logoIv.image = GFImages.ghLogo.image
        
        let size: CGFloat = 200
        
        NSLayoutConstraint.activate([
            logoIv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoIv.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoIv.heightAnchor.constraint(equalToConstant: size),
            logoIv.widthAnchor.constraint(equalToConstant: size),
        ])
    }
    
    private func configureUsernameTf() {
        view.addSubview(usernameTf)
        usernameTf.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTf.topAnchor.constraint(equalTo: logoIv.bottomAnchor, constant: 48),
            usernameTf.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            usernameTf.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameTf.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func configureVersionLb() {
        view.addSubview(versionLb)
        versionLb.text = "v\(Bundle.main.appVersion) (\(Bundle.main.appBuild))"
        
        NSLayoutConstraint.activate([
            versionLb.topAnchor.constraint(equalTo: usernameTf.bottomAnchor, constant: 10),
            versionLb.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            versionLb.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func configuregetUserBt() {
        view.addSubview(getUserBt)
        getUserBt.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            getUserBt.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            getUserBt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            getUserBt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            getUserBt.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    
    // MARK: Actions
    
    @objc private func pushFollowersListVC() {
        guard let username = usernameTf.text, !username.isEmpty else {
            presentGFAlert(title: "SearchViewController.title_empty_username".localized(), message: "SearchViewController.description_empty_username".localized())
            return
        }
        
        // Dismisses the keyboard when exiting the view controller
        usernameTf.resignFirstResponder()
        
        let followersListVC = UsersListViewController(username: username)
        navigationController?.pushViewController(followersListVC, animated: true)
    }

}


// MARK: - Delegates

extension SearchViewController: UITextFieldDelegate {
    
    // Gets called when the user presses 'Done' on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListVC()
        return true
    }
    
}

extension SearchViewController: KeyboardDismissable {
    
    func createDismissKeyboardTapGesture() {
        /*
         UIView.endEditing means that the first view that's going to intercept the
         tap event (in our case, the TextField) will stop editing. This hides the
         keyboard when tapping outside the keyboard and the TextField.
         */
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
}
