//
//  LoveButton.swift
//  MemPi
//
//  Created by Batuhan Karababa on 5.11.2020.
//

import Foundation
import UIKit

class LoveButton:UIView{
    
    //MARK: - Properties
    
    private lazy var iconImageView:UIImageView = {
        let imgView = UIImageView(image: ct_Image.coinIcon)
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    

    private lazy var textLabel:UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .center
        label.text = "Hello"
        label.textColor = ct_Color.purple
        return label
    }()
    
    //MARK: - Lifecycle
    
    init(labelText:String,image:UIImage) {
        super.init(frame: .zero)
        textLabel.text = labelText
        iconImageView.image = image
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
        layer.cornerRadius = 15
        
        addSubview(iconImageView)
        
        iconImageView.setDimension(size: .init(width: bounds.size.width / 3.50, height: bounds.size.width / 3.50))
        iconImageView.setCenterY(anchor: centerYAnchor)
        iconImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: 30).isActive = true
        
        addSubview(textLabel)
        textLabel.font = UIFont(name: ct_SFProRounded.heavy, size: bounds.size.width / 8)
        textLabel.setCenterY(anchor: centerYAnchor)
        textLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: iconImageView.leadingAnchor,padding: .init(top: 0, left: 6, bottom: 0, right: 4))

    }
    
}
