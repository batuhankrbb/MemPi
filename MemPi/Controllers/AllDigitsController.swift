//
//  AllDigitsController.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit
import GoogleMobileAds

class AllDigitsController:CustomViewController, GADBannerViewDelegate{
    
    //MARK: - Properties
    
    private let allDigitsView = AllDigitsView()
    
    private let reuseDigitCell = "AllDigitsCell"
    
    private var digitList = ["3","."] + PI.PI_ARRAY
    
    private var digitsForPresent = [String]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
        configureAds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - Helpers
    
    private func configureUI(){
        view.addSubview(allDigitsView)
        allDigitsView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    private func configureAds(){
        allDigitsView.bannerAds.adUnitID = ct_Ads.banner_allDigits
        allDigitsView.bannerAds.rootViewController = self
        allDigitsView.bannerAds.load(GADRequest())
        allDigitsView.bannerAds.delegate = self
    }
    
    
    private func configureCollectionView(){
        allDigitsView.allDigitsCollectionView.register(AllDigitCell.self, forCellWithReuseIdentifier: reuseDigitCell)
        allDigitsView.allDigitsCollectionView.delegate = self
        allDigitsView.allDigitsCollectionView.dataSource = self
        allDigitsView.allDigitsCollectionView.alwaysBounceHorizontal = true
        allDigitsView.allDigitsCollectionView.reloadData()
    }
    
}

extension AllDigitsController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return digitList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseDigitCell, for: indexPath) as? AllDigitCell{
            cell.numbers = digitList[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        allDigitsView.pageShowView.number = page
    }
}
