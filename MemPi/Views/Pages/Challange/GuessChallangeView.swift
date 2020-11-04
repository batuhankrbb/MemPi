//
//  GuessChallangeView.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit

class GuessChallangeView:NumberPadView{
    
    //MARK: - Properties
    
    var digit:Int = 0{
        didSet{
            digitNumbersLabel.text = "Digit: \(digit)"
        }
    }
    
    var isGuided = false
    
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
    
    lazy var hintView:SpendCoinView = {
        let spendCoin = SpendCoinView(image: ct_Image.hintIcon)
        spendCoin.number = 10
        return spendCoin
    }()
    
    lazy var answerView:SpendCoinView = {
        let spendCoin = SpendCoinView(image: ct_Image.answerIcon)
        spendCoin.number = 20
        return spendCoin
    }()
    
    lazy var heartImageView:UIImageView = {
        let imageView = UIImageView(image: ct_Image.hearts3)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
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
        
        answerView.isUserInteractionEnabled = true
        hintView.isUserInteractionEnabled = true
        backgroundColor = ct_Color.pink
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = .init(width: bounds.size.width / 11, height: bounds.size.height / 7)
        flowLayout.scrollDirection = .horizontal
        piNumberCollectionView.collectionViewLayout = flowLayout
        piNumberCollectionView.backgroundColor = .clear
        piNumberCollectionView.isUserInteractionEnabled = false
        addSubview(piNumberCollectionView)
        
        
        piNumberCollectionView.setHeight(number: bounds.size.height / 7)
        piNumberCollectionView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        
        
        
        addSubview(lineView1)
        lineView1.anchor(top: piNumberCollectionView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        lineView1.setHeight(number: 3)
        
        addSubview(digitNumbersLabel)
        digitNumbersLabel.anchor(top: lineView1.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        
        
        addSubview(lineView2)
        lineView2.anchor(top: digitNumbersLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        lineView2.setHeight(number: 3)
        
        var numberPad:UIStackView!
        if ct_Device.height >= 1360{
            numberPad = makeNumberStack(buttonSize: bounds.size.width / 4.5)
        }else{
            numberPad = makeNumberStack(buttonSize: bounds.size.width / 4.3)
        }
        
        addSubview(numberPad)
        numberPad.anchor(top: nil, leading: nil, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 20, bottom: 40, right: 20))
        numberPad.setCenterX(anchor: centerXAnchor)
        
        addSubview(hintView)
        hintView.setDimension(size: .init(width: ct_Device.width / 3, height: ct_Device.height / 9))
        hintView.anchor(top: nil, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 12, bottom: 40, right: 0))
        
        addSubview(answerView)
        answerView.setDimension(size: .init(width: ct_Device.width / 3, height: ct_Device.height / 9))
        answerView.anchor(top: nil, leading: nil, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 40, right: 12))
        
        addSubview(heartImageView)
        heartImageView.anchor(top: lineView2.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 12, left: 0, bottom: 0, right: 0))
        heartImageView.setCenterX(anchor: centerXAnchor)
        heartImageView.setDimension(size: .init(width: 100, height: 40))
        
        
    }
    
    func makeGuided(buttonNum:Int){
        isGuided = true
        numberList.forEach { (numButton) in
            numButton.backgroundColor = .clear
            numButton.setTitleColor(ct_Color.white, for: .normal)
            numButton.isUserInteractionEnabled = false
        }
        
        numberList[buttonNum].isUserInteractionEnabled = true
        numberList[buttonNum].backgroundColor = ct_Color.purple
        numberList[buttonNum].setTitleColor(ct_Color.white, for: .normal)
    }
    
    
    func removeGuide(){
        isGuided = false
        [number1,number2,number3,number4,number5,number6,number7,number8,number9,number0].forEach { (numButton) in
            numButton.backgroundColor = .clear
            numButton.setTitleColor(ct_Color.white, for: .normal)
            numButton.isUserInteractionEnabled = true
        }
    }
    
    
}
