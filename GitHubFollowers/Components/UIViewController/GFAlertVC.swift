//
//  GFAlertVC.swift
//  GitHubFollowers
//
//  Created by JC on 27/6/22.
//

import UIKit

class GFAlertVC: UIViewController {

    private let alertTitle: String
    private let message: String
    private let buttonTitle: String
    
    private let containerView = GFAlertContainerView()
    private let titleLb = GFTitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLb = GFBodyLabel(textAlignment: .center)
    private let actionBt = GFButton(color: .systemPink, title: "OK", image: SFSymbols.confirm.image)
    
    private let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackgroundBlur()
        configureContainerView()
        
        configureTitleLb()
        configureActionBt()
        configureMessageLb()
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    private func configureBackgroundBlur() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = view.bounds
        blurredEffectView.alpha = 0.75
        view.addSubview(blurredEffectView)
    }
    
    private func configureContainerView() {
        view.addSubview(containerView)
        
        let height: CGFloat = 220
        let width: CGFloat = 280
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: height),
            containerView.widthAnchor.constraint(equalToConstant: width),
        ])
    }
    
    private func configureTitleLb() {
        containerView.addSubview(titleLb)
        
        titleLb.text = alertTitle
        
        NSLayoutConstraint.activate([
            titleLb.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLb.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLb.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
        ])
    }
    
    // We configure the actionBt before the messageLb because the position of the messageLb depends on the position of actionBt
    private func configureActionBt() {
        containerView.addSubview(actionBt)
        
        actionBt.setTitle(buttonTitle, for: .normal)
        actionBt.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionBt.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionBt.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionBt.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
        ])
    }
    
    private func configureMessageLb() {
        containerView.addSubview(messageLb)
        
        messageLb.text = message
        messageLb.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLb.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 8),
            messageLb.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLb.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLb.bottomAnchor.constraint(equalTo: actionBt.topAnchor, constant: -12),
        ])
    }

}
