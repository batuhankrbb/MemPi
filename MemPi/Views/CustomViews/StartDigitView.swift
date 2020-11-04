//
//  StartDigitView.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit

class StartDigitView:UIView{
    
    //MARK - Lifecycle
    
    private lazy var startLabel:UILabel = {
        let lbl = UILabel()
        lbl.textColor = ct_Color.purple
        lbl.text = "Starting Digit:"
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.4
        return lbl
    }()
    
    
    lazy var numberTextField:UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = ct_Color.white
        textfield.placeholder = "0"
        textfield.textAlignment = .center
        textfield.textColor = .black
        textfield.layer.cornerRadius = 20
        textfield.keyboardType = .numberPad
        textfield.layer.borderColor = ct_Color.gray.cgColor
        textfield.layer.borderWidth = 1
        return textfield
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        numberTextField.font = UIFont(name: ct_SFProRounded.medium, size: bounds.size.width / 10 )
        numberTextField.setDimension(size: .init(width: bounds.size.width / 2, height: bounds.size.height / 1.3))
        startLabel.font = UIFont(name: ct_SFProRounded.semiBold, size: bounds.size.width / 10)
    }
    
    //MARK: - Helpers
    private func configureUI(){
        backgroundColor = ct_Color.softPink
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 20
        
        addSubview(numberTextField)
        numberTextField.setCenterY(anchor: centerYAnchor)
        
        numberTextField.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 6))
        
        addSubview(startLabel)
        startLabel.anchor(top: numberTextField.topAnchor, leading: leadingAnchor, bottom: numberTextField.bottomAnchor, trailing: numberTextField.leadingAnchor,padding: .init(top: 0, left: 8, bottom: 6, right: 8))
        
    }
    
    
}
