//
//  TrainingStartController.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit
import GoogleMobileAds

class TrainingStartController: CustomInterstitialController, GADBannerViewDelegate {
    
    //MARK: - Properties
    private lazy var trainingStartView = TrainingStartView()
    
    private var adsId = ct_Ads.interstitial_training
    
    private var startDigit = 0
    
    private var rewardedAdService = RewardedAdService(advertisementID: ct_Ads.rewarded_trainingStart)
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTargets()
        interstitial = createAndLoadInterstitial(advertisementID: adsId)
        configureAds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        trainingStartView.coinShowView.number = UserDefaultsService.shared.getCoin()
        navigationController?.navigationBar.isHidden = false
        
    }
    
    //MARK: - Helpers
    private func configureUI(){
        view.backgroundColor = ct_Color.pink
        view.addSubview(trainingStartView)
        trainingStartView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    private func addTargets(){
        trainingStartView.playButton.addTarget(self, action: #selector(playClicked), for: .touchUpInside)
        trainingStartView.watchAdsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(watchAdsClicked)))
    }
    
    private func startTraining(startDigit:Int){
        let trainingController = TrainingController()
        trainingController.trainingService = TrainingService(currentDigit: startDigit == 0 ? 0 : startDigit - 1)
        navigationController?.pushViewController(trainingController, animated: true)
    }
    
    private func configureAds(){
        trainingStartView.bannerAds.adUnitID = ct_Ads.banner_trainingStart
        trainingStartView.bannerAds.rootViewController = self
        trainingStartView.bannerAds.load(GADRequest())
        trainingStartView.bannerAds.delegate = self
    }
    
    //MARK: - Selectors
    @objc private func playClicked(){
        var startDigitText = trainingStartView.startDigitView.numberTextField.text ?? "0"
        if startDigitText.isEmpty == true {startDigitText = "0"}
    
        let startDigit = Int(startDigitText) ?? -1
            
        if startDigit < 0 || startDigit >= 99_999{
            showAlert(message: "Start digit should be between 0 and 99.998")
            return
        }
        self.startDigit = startDigit
        showAds()
    }
    
    @objc private func watchAdsClicked(){
        if rewardedAdService.rewardedAd?.isReady == true {
            rewardedAdService.rewardedAd?.present(fromRootViewController: self, delegate:self)
        }else{
            showAlert(title: "Oops!", message: "Advertisement is not ready for now. We are really sorry for that 😭 Please try again in a few minutes.")
        }
    }
}

extension TrainingStartController:GADRewardedAdDelegate{
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        rewardedAdService.reloadRewardedAd()
        rewardedAdService.rewardedAdIsWatched { (newMoney) in
            trainingStartView.coinShowView.number = newMoney
            showAlert(title: "You got rich 🤑", message: "You've earned 30 Coins!!!")
        }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial(advertisementID: adsId)
        startTraining(startDigit: startDigit)
    }
    
    func showAds(){
        if interstitial.isReady{
            interstitial.present(fromRootViewController: self)
        }else{
            startTraining(startDigit: startDigit)
        }
    }
}
