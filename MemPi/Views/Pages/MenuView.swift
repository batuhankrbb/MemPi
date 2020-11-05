//
//  MenuView.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit

class MenuView:UIView{
    
    //MARK: - Properties
    
    lazy var appLogo:UIImageView = {
        let imgView = UIImageView(image: ct_Image.appLogo)
        imgView.contentMode = .scaleToFill
        return imgView
    }()
    
    
     private lazy var soundImageView:UIImageView = {
        let imageView = UIImageView(image: ct_Image.soundIcon)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    lazy var soundSwitch:UISwitch = {
        let soundSwitch = UISwitch()
        soundSwitch.isOn = true
        soundSwitch.onTintColor = ct_Color.green
        soundSwitch.tintColor = ct_Color.gray
        soundSwitch.thumbTintColor = ct_Color.white
        return soundSwitch
    }()
    
    lazy var challangeButton = MenuButton(text: "Challenge")
    lazy var trainingButton = MenuButton(text: "Training")
    lazy var digitsButton = MenuButton(text: "100.000 Digits of Pi")
    lazy var shareLoveButton:MenuButton = {
        let menuButton = MenuButton(text: "Share The Love ❤️")
        menuButton.backgroundColor = ct_Color.purple
        return menuButton
    }()
    
    lazy var coinShow = ShowCoinView()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        backgroundColor = ct_Color.pink
        addSubview(appLogo)
        appLogo.setCenterX(anchor: centerXAnchor)
        appLogo.setDimension(size: .init(width: bounds.size.width / 2, height: bounds.size.width / 2))
        appLogo.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 30, left: 0, bottom: 0, right: 0))
        
        let buttonStackView = UIStackView(arrangedSubviews: [challangeButton,trainingButton,digitsButton,shareLoveButton])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 20
        buttonStackView.distribution = .fillEqually
        
        addSubview(buttonStackView)
        buttonStackView.setCenterX(anchor: centerXAnchor)
        buttonStackView.anchor(top: appLogo.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 30, left: 20, bottom: 0, right: 20))
        
        
        addSubview(coinShow)
        coinShow.setDimension(size: .init(width: UIScreen.main.bounds.size.width * 0.5, height: 65))
        coinShow.setCenterX(anchor: centerXAnchor)
        coinShow.anchor(top: buttonStackView.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: bounds.size.height / 24, left: 0, bottom: 0, right: 0))
        
        soundImageView.setDimension(size: .init(width: 35, height: 35))
        let soundStack = UIStackView(arrangedSubviews: [soundImageView,soundSwitch])
        soundStack.spacing = 6
        
        addSubview(soundStack)
        soundStack.setCenterX(anchor: centerXAnchor)
        soundStack.anchor(top: coinShow.bottomAnchor, leading: nil, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil,padding: .init(top: 10, left: 0, bottom: 12, right: 0))
    }
    
}
