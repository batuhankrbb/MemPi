//
//  WatchAdsButton.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit

class WatchAdsView:UIView{
    
    //MARK: - Properties
    
    private lazy var adsImageView:UIImageView = {
        let imgView = UIImageView(image: ct_Image.adsIcon)
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    private lazy var textLabel:UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .center
        label.textColor = ct_Color.purple
        return label
    }()
    
    //MARK - Lifecycle
    
    init(text:String = "GET 50 FREE COIN!") {
        super.init(frame: .zero)
        configureUI(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.font = UIFont(name: ct_SFProRounded.heavy, size: bounds.size.width / 12)
        adsImageView.setDimension(size: .init(width: 55, height: bounds.size.height / 1.5))
    }
    
    //MARK: - Helpers
    
    private func configureUI(text:String){
        layer.cornerRadius = 10
        backgroundColor = ct_Color.softPink
        
        addSubview(adsImageView)
        adsImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 23, bottom: 0, right: 0))
        adsImageView.setCenterY(anchor: centerYAnchor)
        
        addSubview(textLabel)
        textLabel.anchor(top: topAnchor, leading: adsImageView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 8, bottom: 6, right: 4))
        textLabel.text = text
    }
    
    
}
