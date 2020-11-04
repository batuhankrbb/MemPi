//
//  PlainShowStatsView.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit
class PlainShowStatsView:UIView{
    
    //MARK: - Properties
    
    var number = 0{
        didSet{
            numberLabel.text = "\(number)"
        }
    }
    
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
    
    init(labelText:String) {
        super.init(frame: .zero)
        decriptionScoreLabel.text = labelText
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
        decriptionScoreLabel.font = UIFont(name: ct_SFProRounded.medium, size: bounds.size.width / 12.1)
        
        addSubview(pinkView)
        pinkView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 10, left: 20, bottom: 10, right: 0))
        
        
        let labelStack = UIStackView(arrangedSubviews: [decriptionScoreLabel,numberLabel])
        labelStack.axis = .vertical
        labelStack.spacing = -5
        labelStack.distribution = .fillProportionally
        
        addSubview(labelStack)
        labelStack.anchor(top: pinkView.topAnchor, leading: pinkView.leadingAnchor, bottom: pinkView.bottomAnchor, trailing: pinkView.trailingAnchor,padding: .init(top: 2, left: 2, bottom: 2, right: 2))
        
    }
    
}
