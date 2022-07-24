//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by JC on 21/6/22.
//

import UIKit

class SearchVC: UIViewController {

    private let logoIv = UIImageView()
    private let usernameTf = GFTextField()
    private let getFollowersBt = GFButton(color: .systemGreen, title: "Get followers", image: SFSymbols.followers.image)
    
    private let padding: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureLogoIv()
        configureUsernameTf()
        configureGetFollowersBt()
        
        
        createDismissKeyboardTapGesture()
        /*
        addKeyboardObservers()
         */
    }
    
    // Gets called every time the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // We change the value of setNavigationBarHidden in viewWillAppear because viewDidLoad gets called only once, so if we go back to this ViewController from another ViewController, the navigation bar will be visible.
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc private func pushFollowersListVC() {
        guard let username = usernameTf.text, !username.isEmpty else {
            presentGFAlert(title: "Empty username", message: "Please, enter a username. We need to know who to look for.")
            return
        }
        
        usernameTf.resignFirstResponder() // dismisses the keyboard when exiting the view controller
        
        let followersListVC = FollowersListVC(username: username)
        navigationController?.pushViewController(followersListVC, animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground // background color will change depending on the device theme (light/dark)
    }
    
    private func configureLogoIv() {
        view.addSubview(logoIv)
        
        // Not necessary to do for usernameTf and getFollowersBt because the value of the property is already changed in the initializer of their respective classes.
        logoIv.translatesAutoresizingMaskIntoConstraints = false
        logoIv.image = Images.ghLogo.image
        
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
    
    private func configureGetFollowersBt() {
        view.addSubview(getFollowersBt)
        getFollowersBt.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            getFollowersBt.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            getFollowersBt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            getFollowersBt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            getFollowersBt.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

}

extension SearchVC: UITextFieldDelegate {
    /**
     Gets called when the user press 'Done' on the keyboard
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListVC()
        return true
    }
}

extension SearchVC: KeyboardDismissable {
    
    func createDismissKeyboardTapGesture() {
        // UIView.endEditing means that the first view that's going to intercept the tap event (in our case, it will be the TextField) will stop editing. What this does is to hide the keyboard when tapping outside the keyboard and the TextField.
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
}
