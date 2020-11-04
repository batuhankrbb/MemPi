//
//  SpendCoinView.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit


class SpendCoinView:UIView{
    
    //MARK: - Properties
    
    var number = 30{
        didSet{
            numberLabel.text = "\(number)"
        }
    }
    
    private lazy var iconImageView:UIImageView = {
        let imgView = UIImageView(image: ct_Image.hintIcon)
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private lazy var pinkView:UIView = {
        let view = UIView()
        view.backgroundColor = ct_Color.softPink
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var numberLabel:UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .center
        label.text = "\(number)"
        label.textColor = ct_Color.purple
        return label
    }()
    
    private lazy var coinIcon:UIImageView = {
        let imageView = UIImageView(image: ct_Image.coinIcon)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    //MARK: - Lifecycle
    
    init(image:UIImage) {
        super.init(frame: .zero)
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
        backgroundColor = .clear
        
        numberLabel.font = UIFont(name: ct_SFProRounded.heavy, size: bounds.size.width / 6)

        addSubview(pinkView)
        addSubview(iconImageView)
        addSubview(numberLabel)
        addSubview(coinIcon)

        iconImageView.setDimension(size: .init(width: bounds.size.width / 2, height: bounds.size.width / 2))
        iconImageView.setCenterY(anchor: centerYAnchor)
        iconImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true

        pinkView.setDimension(size: .init(width: bounds.size.width / 1.1, height: bounds.size.height / 2))
        pinkView.setCenterY(anchor: centerYAnchor)
        pinkView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: iconImageView.bounds.size.width / 2, bottom: 0, right: 0))
        

        numberLabel.setCenterY(anchor: pinkView.centerYAnchor)
        numberLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: bounds.size.width / 4.5))
        
        coinIcon.setCenterY(anchor: centerYAnchor)
        coinIcon.setDimension(size: .init(width: bounds.size.width / 6, height: bounds.size.width / 6))
        coinIcon.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 4))
    }
}
