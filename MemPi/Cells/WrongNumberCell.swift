//
//  WrongNumberCell.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit

class WrongNumberCell:UICollectionViewCell{
    
    //MARK: - Properties
    
    var challangeNumber = PiCollectionNumber(number: "1"){
        didSet{
            adjustCell(number:challangeNumber)
        }
    }
    
    lazy var numberLabel:UILabel = {
        let label = UILabel()
        label.textColor = ct_Color.white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.text = challangeNumber.number
        label.textAlignment = .center
        label.font = UIFont(name: ct_SFProRounded.heavy, size: bounds.size.height / 2.2)
        label.minimumScaleFactor = 0.5
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
    
    private func adjustCell(number:PiCollectionNumber){
        numberLabel.text = number.number
        numberLabel.textColor = ct_Color.red
    }
    
    private func configureUI(){
        backgroundColor = .clear
        addSubview(numberLabel)
        numberLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
}
