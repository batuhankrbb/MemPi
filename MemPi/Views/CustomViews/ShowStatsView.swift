//
//  ShowStatsView.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit
class ShowStatsView:UIView{
    
    //MARK: - Properties
    
    var number = 0{
        didSet{
            numberLabel.text = "\(number)"
        }
    }
    
    private lazy var iconImageView:UIImageView = {
        let imgView = UIImageView(image: ct_Image.lastTimeIcon)
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    private lazy var pinkView:UIView = {
        let view = UIView()
        view.backgroundColor = ct_Color.softPink
        view.layer.cornerRadius = 15
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
    
    private lazy var decriptionScoreLabel:UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .center
        label.textColor = ct_Color.purple
        return label
    }()
    
    //MARK: - Lifecycle
    
    init(labelText:String,image:UIImage) {
        super.init(frame: .zero)
        decriptionScoreLabel.text = labelText
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
        
        numberLabel.font = UIFont(name: ct_SFProRounded.heavy, size: bounds.size.width / 6.9)
        decriptionScoreLabel.font = UIFont(name: ct_SFProRounded.medium, size: bounds.size.width / 12.1)
        
        addSubview(pinkView)
        pinkView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 6, left: 20, bottom: 6, right: 0))
        
        addSubview(iconImageView)
        iconImageView.setDimension(size: .init(width: bounds.size.width / 3.50, height: bounds.size.width / 3.50))
        iconImageView.setCenterY(anchor: centerYAnchor)
        iconImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        
        let labelStack = UIStackView(arrangedSubviews: [decriptionScoreLabel,numberLabel])
        labelStack.axis = .vertical
        labelStack.spacing = -5
        labelStack.distribution = .fillProportionally
        
        addSubview(labelStack)
        labelStack.anchor(top: pinkView.topAnchor, leading: pinkView.leadingAnchor, bottom: pinkView.bottomAnchor, trailing: pinkView.trailingAnchor,padding: .init(top: 2, left: (iconImageView.frame.size.width / 2) + 6, bottom: 2, right: 2))
        
    }
    
}
