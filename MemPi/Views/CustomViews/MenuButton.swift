//
//  MenuButton.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit

class MenuButton:UIButton{
    
    //MARK - Lifecycle
    
    var fontDivide:CGFloat!
    
    init(text:String,fontDivide:CGFloat = 11) {
        super.init(frame: .zero)
        configureUI(text: text)
        self.fontDivide = fontDivide
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.font = UIFont(name: ct_SFProRounded.bold, size: bounds.size.width / fontDivide)
    }
    
    //MARK: - Helpers
    private func configureUI(text:String){
        setTitleColor(UIColor.init(white: 1, alpha: 0.3), for: .highlighted)
        backgroundColor = .clear
        layer.borderColor = ct_Color.white.cgColor
        layer.borderWidth = 3
        layer.cornerRadius = 20
        setTitle(text, for: .normal)
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = 0.3
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}

