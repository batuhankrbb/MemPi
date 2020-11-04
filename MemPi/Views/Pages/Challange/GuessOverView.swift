//
//  GuessOverView.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit

class GuessOverView:UIView{
    
    //MARK: - Properties
    
    private lazy var failImageView:UIImageView = {
        let imgView = UIImageView(image: ct_Image.failIcon)
        imgView.contentMode = .scaleToFill
        return imgView
    }()
    
    lazy var digitsRememberView = ShowStatsView(labelText: "Remembered:", image: ct_Image.memorizeIcon)
    
    lazy var yourBestView = ShowStatsView(labelText: "Your Best:", image: ct_Image.recordIcon)
    
    lazy var earnedView = ShowStatsView(labelText: "You Earned:", image: ct_Image.coinIcon)
    
    lazy var watchAdsView:WatchAdsView = {
        let watcAds = WatchAdsView()
        watcAds.layer.borderWidth = 1
        watcAds.layer.borderColor = UIColor.black.cgColor
        watcAds.backgroundColor = ct_Color.white
        return watcAds
    }()
    
    lazy var restartButton:MenuButton = {
        let restartButton = MenuButton(text: "RESTART")
        restartButton.backgroundColor = ct_Color.purple
        menuButton.layer.borderWidth = 0
        return restartButton
    }()
    
    lazy var menuButton:MenuButton = {
        let menuButton = MenuButton(text: "MENU")
        menuButton.backgroundColor = ct_Color.purple
        menuButton.layer.borderWidth = 0
        return menuButton
    }()
    
    lazy var shareButton = ShareButton()
    
    private lazy var overLabel:UILabel = {
        let lbl = UILabel()
        lbl.textColor = ct_Color.red
        lbl.text = "GAME OVER"
        return lbl
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    //MARK: - Helpers
    
    private func configureUI(){
        backgroundColor = ct_Color.softPink
        
        overLabel.font = UIFont(name: ct_SFProRounded.bold, size: bounds.size.width / 10)
        
        
        addSubview(failImageView)
        failImageView.setDimension(size: .init(width: bounds.size.width / 3, height: bounds.size.width / 3))
        failImageView.setCenterX(anchor: centerXAnchor)
        failImageView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        
        
        addSubview(overLabel)
        overLabel.setCenterX(anchor: centerXAnchor)
        overLabel.anchor(top: failImageView.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 4, left: 0, bottom: 0, right: 0))
        
        let scoreStackView = UIStackView(arrangedSubviews: [yourBestView,earnedView])
        scoreStackView.distribution = .fillEqually
        scoreStackView.spacing = 20
        
        
        addSubview(scoreStackView)
        scoreStackView.anchor(top: overLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 10, left: 6, bottom: 0, right: 6))
        scoreStackView.subviews.forEach { (view) in
            view.setHeight(number: bounds.size.height / 12)
        }
        
        let rememberStack = UIStackView(arrangedSubviews: [digitsRememberView,watchAdsView])
        rememberStack.distribution = .fillEqually
        rememberStack.spacing = 20
        addSubview(rememberStack)
        rememberStack.anchor(top: scoreStackView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 50, left: 5, bottom: 0, right: 6))
        rememberStack.setHeight(number: bounds.size.height / 12)
        digitsRememberView.setHeight(number: watchAdsView.bounds.height)
        
        let buttonStack = UIStackView(arrangedSubviews: [restartButton,menuButton])
        buttonStack.axis = .vertical
        buttonStack.spacing = 8
        addSubview(buttonStack)
        buttonStack.subviews.forEach { (buttonView) in
            buttonView.setDimension(size: .init(width: bounds.size.width / 1.5, height: bounds.size.height / 12))
        }
        buttonStack.anchor(top: rememberStack.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 12, left: 0, bottom: 0, right: 0))
        buttonStack.setCenterX(anchor: centerXAnchor)
        
        addSubview(shareButton)
        shareButton.setDimension(size: .init(width: bounds.size.width / 1.2, height: bounds.size.height / 12))
        shareButton.anchor(top: buttonStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 30, left: 6, bottom: 0, right: 6))
        shareButton.setCenterX(anchor: centerXAnchor)
    }
    
}
