//
//  ShowCoinView.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit


class ShowCoinView:UIView{
    
    //MARK: - Properties
    
    var number = 0{
        didSet{
            numberLabel.text = "\(number)"
        }
    }
    
    private lazy var iconImageView:UIImageView = {
        let imgView = UIImageView(image: ct_Image.coinIcon)
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    private lazy var yellowView:UIView = {
        let view = UIView()
        view.backgroundColor = ct_Color.yellow
        view.layer.cornerRadius = 14
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
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
        backgroundColor = .clear

        numberLabel.font = UIFont(name: ct_SFProRounded.heavy, size: bounds.size.width / 7.2)
        
        addSubview(yellowView)
        yellowView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 6, left: 20, bottom: 6, right: 0))
        
        addSubview(iconImageView)
        iconImageView.setDimension(size: .init(width: bounds.size.width / 3.2, height: bounds.size.width / 3))
        iconImageView.setCenterY(anchor: centerYAnchor)
        iconImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        
        addSubview(numberLabel)
        numberLabel.anchor(top: yellowView.topAnchor, leading: yellowView.leadingAnchor, bottom: yellowView.bottomAnchor, trailing: yellowView.trailingAnchor,padding: .init(top: 2, left: (iconImageView.frame.size.width / 2) - 4, bottom: 2, right: 2))
    }
    
    
}
