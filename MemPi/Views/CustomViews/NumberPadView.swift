//
//  NumberPadView.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit

class NumberPadView:UIView{
    //MARK: - Properties
    
    lazy var number0 = NumberButton(number: 0)
    lazy var number1 = NumberButton(number: 1)
    lazy var number2 = NumberButton(number: 2)
    lazy var number3 = NumberButton(number: 3)
    lazy var number4 = NumberButton(number: 4)
    lazy var number5 = NumberButton(number: 5)
    lazy var number6 = NumberButton(number: 6)
    lazy var number7 = NumberButton(number: 7)
    lazy var number8 = NumberButton(number: 8)
    lazy var number9 = NumberButton(number: 9)
    
    var numberList:[NumberButton]{
        return  [number0,number1,number2,number3,number4,number5,number6,number7,number8,number9]
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
    }
    
    //MARK: - Helpers
    
    func makeNumberStack(buttonSize number: CGFloat) -> UIStackView{
        numberList.forEach { (numButton) in
            numButton.makeRound(number: number)
        }
        let stackViewTop = UIStackView(arrangedSubviews: [numberList[1],numberList[2],numberList[3]])
        let stackViewMid = UIStackView(arrangedSubviews: [numberList[4],numberList[5],numberList[6]])
        let stackViewBottom = UIStackView(arrangedSubviews: [numberList[7],numberList[8],numberList[9]])
        let stackViewZero = UIStackView(arrangedSubviews: [UIView(),numberList[0],UIView()])
        [stackViewTop,stackViewMid,stackViewBottom,stackViewZero].forEach { (stackView) in
            stackView.spacing = 20
            stackView.distribution  = .fillEqually
        }
        
        let stackViewTotal = UIStackView(arrangedSubviews: [stackViewTop,stackViewMid,stackViewBottom,stackViewZero])
        stackViewTotal.axis = .vertical
        stackViewTotal.spacing = 16
        stackViewTotal.distribution = .fillEqually
 
        return stackViewTotal
    }
    
    
}
