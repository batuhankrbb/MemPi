//
//  AllDigitsView.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit
import GoogleMobileAds
class AllDigitsView:UIView{
    
    //MARK: - Properties
    
    lazy var allDigitsCollectionView:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let piNumberCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return piNumberCollectionView
    }()
    
    private lazy var digitsLabel:UILabel = {
        let digitLbl = UILabel()
        digitLbl.text = "100.000\nDIGITS"
        digitLbl.textColor = ct_Color.white
        digitLbl.font = UIFont(name: ct_SFProRounded.heavy, size: 60)
        digitLbl.numberOfLines = 2
        digitLbl.adjustsFontSizeToFitWidth = true
        digitLbl.minimumScaleFactor = 0.3
        digitLbl.textAlignment = .center
        return digitLbl
    }()
    
    lazy var bannerAds:GADBannerView = {
        let banner = GADBannerView(adSize: kGADAdSizeBanner)
        return banner
    }()
    
    lazy var pageShowView = PlainShowStatsView(labelText: "Page:")
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
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
        
        addSubview(digitsLabel)
        digitsLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 6, left: 20, bottom: 0, right: 20))
        
        
        addSubview(bannerAds)
        bannerAds.anchor(top: nil, leading: nil, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil)
        bannerAds.setCenterX(anchor: centerXAnchor)
        
        pageShowView.setDimension(size: .init(width: bounds.size.width / 2.5, height: bounds.size.height / 9)) //
        
        let totalStack = UIStackView(arrangedSubviews: [pageShowView,UIView()])
        totalStack.distribution = .equalCentering
        
        addSubview(totalStack)
        totalStack.anchor(top: nil, leading: leadingAnchor, bottom: bannerAds.topAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 8, bottom: 14, right: 8))
        totalStack.setHeight(number: bounds.size.height / 11)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = .init(width: 60, height: 60)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .horizontal
        
        allDigitsCollectionView.collectionViewLayout = flowLayout
        allDigitsCollectionView.backgroundColor = .clear
        allDigitsCollectionView.alwaysBounceHorizontal = true
        allDigitsCollectionView.isPagingEnabled = true
        
        addSubview(allDigitsCollectionView)
        allDigitsCollectionView.anchor(top: digitsLabel.bottomAnchor, leading: nil, bottom: totalStack.topAnchor, trailing: nil,padding: .init(top: 16, left: 0, bottom: 16, right: 0))
        allDigitsCollectionView.setCenterX(anchor: centerXAnchor)
        
        let rowCount = 7
        let widthNumber = 40 * rowCount + (10 * rowCount - 1)
        
        allDigitsCollectionView.setWidth(number: CGFloat(widthNumber))
    }
    
}
