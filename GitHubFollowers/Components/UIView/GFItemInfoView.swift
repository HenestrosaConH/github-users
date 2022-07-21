//
//  GFItemInfoView.swift
//  GitHubFollowers
//
//  Created by JC on 3/7/22.
//

import UIKit

enum ItemInfoType: String {
    case repos = "Public Repos"
    case gists = "Gists"
    case followers = "Followers"
    case following = "Following"
}

class GFItemInfoView: UIView {

    private let symbolIv = UIImageView()
    private let titleLb = GFTitleLabel(textAlignment: .left, fontSize: 14)
    private let countLb = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSymbolIv()
        configureTitleLb()
        configureCountLb()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            symbolIv.image = SFSymbols.repos.image
        case .gists:
            symbolIv.image = SFSymbols.gists.image
        case .followers:
            symbolIv.image = SFSymbols.followers.image
        case .following:
            symbolIv.image = SFSymbols.following.image
        }
        
        titleLb.text = itemInfoType.rawValue
        countLb.text = String(count)
    }
    
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
