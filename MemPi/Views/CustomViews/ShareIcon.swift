//
//  ShareIcon.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit
class ShareButton:UIView{
    
    //MARK: - Properties
    private lazy var shareImageView:UIImageView = {
        let imgView = UIImageView(image: ct_Image.shareIcon)
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private lazy var textLabel:UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.font = UIFont(name: ct_SFProRounded.heavy, size: 45)
        label.textAlignment = .center
        label.textColor = ct_Color.green
        return label
    }()
    
    private var shareText:String!
    
    //MARK - Lifecycle
    
    init(text:String = "SHARE YOUR SCORE!") {
        super.init(frame: .zero)
        shareText = text
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI(text:shareText)
    }
    
    //MARK: - Helpers
    private func configureUI(text:String){
        layer.cornerRadius = 10
        backgroundColor = ct_Color.purple
        
        addSubview(shareImageView)
        shareImageView.setDimension(size: .init(width: 55, height: bounds.size.height / 1.5))
        shareImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        shareImageView.setCenterY(anchor: centerYAnchor)
        
        addSubview(textLabel)
        textLabel.anchor(top: topAnchor, leading: shareImageView.trailingAnchor, bottom: shareImageView.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 6, bottom: 4, right:10))
        
        textLabel.text = text
    }
    
    
}
