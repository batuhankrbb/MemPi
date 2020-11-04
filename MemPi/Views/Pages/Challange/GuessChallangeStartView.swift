//
//  GuessChallangeStartView.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit

class GuessChallangeStartView:UIView{
    
    //MARK: - Properties
    
    lazy var guessLabel:UILabel = {
        let guesslbl = UILabel()
        guesslbl.text = "GUESS CHALLENGE"
        guesslbl.textColor = ct_Color.white
        guesslbl.font = UIFont(name: ct_SFProRounded.heavy, size: 70)
        guesslbl.numberOfLines = 2
        guesslbl.adjustsFontSizeToFitWidth = true
        guesslbl.minimumScaleFactor = 0.3
        guesslbl.textAlignment = .center
        return guesslbl
    }()
    
    lazy var recordView = ShowStatsView(labelText: "Your Best:", image: ct_Image.recordIcon)
    lazy var lastScoreView = ShowStatsView(labelText: "Last Score:", image: ct_Image.lastTimeIcon)
    lazy var startDigitView = StartDigitView()
    
    lazy var playButton:MenuButton = {
        let menuButton = MenuButton(text: "PLAY!")
        menuButton.backgroundColor = ct_Color.purple
        menuButton.layer.borderWidth = 0
        return menuButton
    }()
    
    lazy var coinShowView = ShowCoinView()
    
    lazy var watchAdsView = WatchAdsView()
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
        addSubview(guessLabel)
        guessLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 6, left: 20, bottom: 0, right: 20))
        
        let scoreStackView = UIStackView(arrangedSubviews: [recordView,lastScoreView])
        scoreStackView.distribution = .fillEqually
        scoreStackView.spacing = 20
        
        addSubview(scoreStackView)
        scoreStackView.anchor(top: guessLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 10, left: 6, bottom: 0, right: 6))
        scoreStackView.subviews.forEach { (view) in
            view.setHeight(number: bounds.size.height / 12)
        }
        
        addSubview(startDigitView)
        startDigitView.anchor(top: scoreStackView.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: bounds.size.height / 8, left: 0, bottom: 0, right: 0))
        startDigitView.setDimension(size: .init(width: bounds.size.width / 1.3, height: bounds.size.height / 10))
        startDigitView.setCenterX(anchor: centerXAnchor)
        
        addSubview(playButton)
        playButton.setDimension(size: .init(width: bounds.size.width / 1.5, height: bounds.size.height / 12))
        playButton.setCenterX(anchor: centerXAnchor)
        playButton.anchor(top: startDigitView.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        
        addSubview(watchAdsView)
        watchAdsView.setDimension(size: .init(width: bounds.size.width / 1.2, height: bounds.size.height / 11))
        watchAdsView.anchor(top: playButton.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: bounds.size.height / 14, left: 0, bottom: 0, right: 0))
        watchAdsView.setCenterX(anchor: centerXAnchor)
        
        addSubview(coinShowView)
        coinShowView.setDimension(size: .init(width: bounds.size.width / 3, height: bounds.size.height / 14))
        coinShowView.anchor(top: watchAdsView.bottomAnchor, leading: nil, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil,padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        coinShowView.setCenterX(anchor: centerXAnchor)
    }
    
}
