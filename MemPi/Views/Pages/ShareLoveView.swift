//
//  ShareLoveView.swift
//  MemPi
//
//  Created by Batuhan Karababa on 5.11.2020.
//

import Foundation
import UIKit

class ShareLoveView:UIView{
    
    //MARK: - Properties
    
    lazy var supportButton = MenuButton(text: "Need Support? 🙋")
    lazy var rateUsButton = MenuButton(text: "Rate Us 😌")
    
    private lazy var shareLoveLabel:UILabel = {
        let label = UILabel()
        label.text = "SHARE LOVE"
        label.textColor = ct_Color.white
        label.minimumScaleFactor = 0.3
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var heartImage:UIImageView = {
        let image = UIImageView(image: ct_Image.heartIcon)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureUI(){
        backgroundColor = ct_Color.pink
        
        shareLoveLabel.font = UIFont(name: ct_SFProRounded.heavy, size: bounds.size.width / 5)
        addSubview(shareLoveLabel)
        shareLoveLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 10, left: 20, bottom: 0, right: 20))
        
        addSubview(heartImage)
        heartImage.setCenterX(anchor: centerXAnchor)
        heartImage.anchor(top: shareLoveLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: -50, left: 0, bottom: 0, right: 0))
        heartImage.setDimension(size: .init(width: bounds.size.width / 4, height: bounds.size.height / 4))
        
        let buttonStackView = UIStackView(arrangedSubviews: [supportButton,rateUsButton])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 20
        buttonStackView.distribution = .fillEqually
        
        addSubview(buttonStackView)
        buttonStackView.anchor(top: heartImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        
    }
}
