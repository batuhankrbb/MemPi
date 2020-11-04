//
//  TrainingStartView.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit
import GoogleMobileAds

class TrainingStartView:UIView{
    
    //MARK: - Properties
    
    lazy var trainingLabel:UILabel = {
        let guesslbl = UILabel()
        guesslbl.text = "TRANING"
        guesslbl.textColor = ct_Color.white
        guesslbl.font = UIFont(name: ct_SFProRounded.heavy, size: 70)
        guesslbl.numberOfLines = 2
        guesslbl.adjustsFontSizeToFitWidth = true
        guesslbl.minimumScaleFactor = 0.3
        guesslbl.textAlignment = .center
        return guesslbl
    }()
    
    lazy var startDigitView = StartDigitView()
    
    lazy var playButton:MenuButton = {
        let menuButton = MenuButton(text: "PLAY!")
        menuButton.backgroundColor = ct_Color.purple
        menuButton.layer.borderWidth = 0
        return menuButton
    }()
    
    lazy var coinShowView = ShowCoinView()
    
    lazy var watchAdsView = WatchAdsView()
    
    lazy var bannerAds:GADBannerView = {
        let banner = GADBannerView(adSize: kGADAdSizeBanner)
        return banner
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
        backgroundColor = ct_Color.pink
        addSubview(trainingLabel)
        trainingLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 6, left: 20, bottom: 0, right: 20))
        
        
        addSubview(startDigitView)
        startDigitView.anchor(top: trainingLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: bounds.size.height / 13, left: 0, bottom: 0, right: 0))
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
        coinShowView.anchor(top: watchAdsView.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 40, left: 0, bottom: 0, right: 0))
        coinShowView.setCenterX(anchor: centerXAnchor)
        
        addSubview(bannerAds)
        bannerAds.anchor(top: nil, leading: nil, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil)
        bannerAds.setCenterX(anchor: centerXAnchor)
        
    }
    
}
