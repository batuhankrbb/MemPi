//
//  NumberButton.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit


class NumberButton:UIButton{
    
    //MARK - Lifecycle
    
    var number:Int!
    
    init(number:Int) {
        super.init(frame: .zero)
        self.number = number
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI(text: "\(number!)")
    }
    
    //MARK: - Helpers
    private func configureUI(text:String){
        setTitleColor(UIColor.init(white: 1, alpha: 0.3), for: .highlighted)
        setTitleColor(ct_Color.white, for: .normal)
        layer.borderColor = ct_Color.white.cgColor
        layer.borderWidth = 5
        setTitle(text, for: .normal)
        titleLabel?.font = UIFont(name: ct_SFProRounded.bold, size: bounds.size.height / 1.3)
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = 0.1
        titleLabel?.setCenter(size: nil)
    }
    
}
