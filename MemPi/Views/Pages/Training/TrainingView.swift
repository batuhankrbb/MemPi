//
//  TrainingView.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit
import GoogleMobileAds

class TrainingView:NumberPadView{
    
    //MARK: - Properties
    
    var digit:Int = 0{
        didSet{
            digitNumbersLabel.text = "Digit: \(digit)"
        }
    }
    
    private lazy var lineView1:UIView = {
        let view = UIView()
        view.backgroundColor = ct_Color.white
        return view
    }()
    
    private lazy var lineView2:UIView = {
        let view = UIView()
        view.backgroundColor = ct_Color.white
        return view
    }()
    
    private lazy var digitNumbersLabel:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: ct_SFProRounded.medium, size: 40)
        lbl.textColor = ct_Color.white
        lbl.text = "Digit: 0"
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        return lbl
    }()
    
    
    lazy var piNumberCollectionView:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let piNumberCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return piNumberCollectionView
    }()
    
    lazy var menuButton:MenuButton = {
        let menuButton = MenuButton(text: "Click to Exit",fontDivide: 5)
        menuButton.backgroundColor = ct_Color.purple
        menuButton.layer.borderWidth = 0
        return menuButton
    }()
    
    var numberPad:UIStackView!
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        backgroundColor = ct_Color.pink
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = .init(width: bounds.size.width / 11, height: bounds.size.height / 7)
        flowLayout.scrollDirection = .horizontal
        piNumberCollectionView.collectionViewLayout = flowLayout
        piNumberCollectionView.backgroundColor = .clear
        piNumberCollectionView.isUserInteractionEnabled = false
        addSubview(piNumberCollectionView)
        
        piNumberCollectionView.setHeight(number: bounds.size.height / 7)
        piNumberCollectionView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 10, bottom: 0, right: 30))
        piNumberCollectionView.setCenterX(anchor: centerXAnchor)
        
        addSubview(lineView1)
        lineView1.anchor(top: piNumberCollectionView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        lineView1.setHeight(number: 3)
        
        addSubview(digitNumbersLabel)
        digitNumbersLabel.anchor(top: lineView1.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        
        
        addSubview(lineView2)
        lineView2.anchor(top: digitNumbersLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        lineView2.setHeight(number: 3)
        
        numberPad = makeNumberStack(buttonSize: bounds.size.width / 4.3)
        
        
        
        addSubview(numberPad)
        numberPad.anchor(top: nil, leading: nil, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 20, bottom: 20, right: 20))
        numberPad.setCenterX(anchor: centerXAnchor)
        
        addSubview(menuButton)
        menuButton.setDimension(size: .init(width: bounds.size.width / 5, height: bounds.size.height / 9))
        menuButton.anchor(top: nil, leading: numberPad.leadingAnchor, bottom: numberPad.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 0, bottom: 8, right: 0))
    }
    
    
    func makeGuided(buttonNum:Int){
        numberList.forEach { (numButton) in
            numButton.backgroundColor = .clear
            numButton.setTitleColor(ct_Color.white, for: .normal)
            numButton.isUserInteractionEnabled = false
        }
        
        numberList[buttonNum].isUserInteractionEnabled = true
        numberList[buttonNum].backgroundColor = ct_Color.purple
        numberList[buttonNum].setTitleColor(ct_Color.white, for: .normal)
    }
}
