//
//  ChallangeOverController.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit
import GoogleMobileAds

final class ChallangeOverController:CustomViewController{
    
    //MARK: - Properties
    private let overView = GuessOverView()
    
    var overModel:OverModel!
    
    private var rewardedAdService = RewardedAdService(advertisementID: ct_Ads.rewarded_gameOver)
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTargets()
    }
    
    //MARK: - Helpers
    
    private func configureUI(){
        view.addSubview(overView)
        overView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        overView.digitsRememberView.number = overModel.rememberedNumber
        overView.earnedView.number = overModel.earned
        overView.yourBestView.number = overModel.best
        UserDefaultsService.shared.increaseCoin(coinToIncrease: overModel.earned)
        UserDefaultsService.shared.setLastScore(score: overModel.rememberedNumber)
    }
    
    private func addTargets(){
        overView.shareButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shareClicked)))
        overView.watchAdsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(watchAdsClicked)))
        overView.menuButton.addTarget(self, action: #selector(menuClicked), for: .touchUpInside)
        overView.restartButton.addTarget(self, action: #selector(restartClicked), for: .touchUpInside)
    }
    
    //MARK: - Selectors
    
    @objc private func shareClicked(){
        shareScore(score: overModel.rememberedNumber)
    }
    
    @objc private func watchAdsClicked(){
        if rewardedAdService.rewardedAd?.isReady == true {
            rewardedAdService.rewardedAd?.present(fromRootViewController: self, delegate:self)
        }else{
            showAlert(title: "Oops!", message: "Advertisement is not ready for now. We are really sorry for that 😭 Please try again in a few minutes.")
        }
    }
    
    @objc private func menuClicked(){
        navigationController?.popToRootViewController(animated: true)
    }
    @objc private func restartClicked(){
        popViewController(popViews: 2)
    }
}


extension ChallangeOverController:GADRewardedAdDelegate{
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) { //1
        rewardedAdService.reloadRewardedAd()
        rewardedAdService.rewardedAdIsWatched { (newMoney) in
            showAlert(title: "You got rich 🤑", message: "You've earned 30 Coins!!!")
        }
    }
}
