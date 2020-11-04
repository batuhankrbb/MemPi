//
//  AllDigitCell.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit

class AllDigitCell:UICollectionViewCell{
    
    //MARK: - Properties
    
    var numbers = "1"{
        didSet{
            numberLabel.text = numbers
        }
    }
    
    private lazy var numberLabel:UILabel = {
        let label = UILabel()
        label.textColor = ct_Color.purple
        label.font = UIFont(name: ct_SFProRounded.medium, size: 30)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.text = numbers
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureUI(){
        backgroundColor = ct_Color.white
        layer.cornerRadius = 12
        addSubview(numberLabel)
        numberLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}
