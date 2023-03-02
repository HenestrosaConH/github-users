//
//  GFItemInfoView.swift
//  GitHubUsers
//
//  Created by JC on 3/7/22.
//

import UIKit

class GFBaseItem: UIView {

    // MARK: - Private Properties
    
    private let symbolIv = UIImageView()
    private let titleLb = GFTitleLabel(textAlignment: .left, fontSize: 14)
    private let countLb = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    
    // MARK: - Initializers
    
    init(itemInfoType: GFItemInfoType, with text: String) {
        super.init(frame: .zero)
        
        configureSymbolIv()
        configureTitleLb()
        configureCountLb()
        
        set(itemInfoType: itemInfoType, with: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public Methods
    
    func set(itemInfoType: GFItemInfoType, with text: String) {
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapItem))
        addGestureRecognizer(gesture)
        
        symbolIv.image = itemInfoType.image
        titleLb.text = itemInfoType.name
        countLb.text = text
    }
    
    
    // MARK: - Internal Methods
    
    @objc internal func didTapItem() { }
    
    
    // MARK: - Private Methods
    
    private func configureSymbolIv() {
        addSubview(symbolIv)
        
        symbolIv.translatesAutoresizingMaskIntoConstraints = false
        symbolIv.contentMode = .scaleAspectFill
        symbolIv.tintColor = .label
        
        let size: CGFloat = 20
        
        NSLayoutConstraint.activate([
            symbolIv.topAnchor.constraint(equalTo: self.topAnchor),
            symbolIv.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolIv.heightAnchor.constraint(equalToConstant: size),
            symbolIv.widthAnchor.constraint(equalToConstant: size),
        ])
    }
    
    private func configureTitleLb() {
        addSubview(titleLb)
        
        NSLayoutConstraint.activate([
            titleLb.centerYAnchor.constraint(equalTo: symbolIv.centerYAnchor),
            titleLb.leadingAnchor.constraint(equalTo: symbolIv.trailingAnchor, constant: 12),
            titleLb.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLb.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    private func configureCountLb() {
        addSubview(countLb)
        
        let topAnchor: CGFloat = 4
        let height: CGFloat = 18
        
        NSLayoutConstraint.activate([
            countLb.topAnchor.constraint(equalTo: symbolIv.bottomAnchor, constant: topAnchor),
            countLb.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLb.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLb.heightAnchor.constraint(equalToConstant: height),
        ])
    }
    
}
