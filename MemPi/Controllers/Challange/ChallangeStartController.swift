//
//  ChallangeStartController.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit
import GoogleMobileAds

final class ChallangeStartController: CustomInterstitialController {
    
    //MARK: - Properties
    lazy var challangeStartView = GuessChallangeStartView()
    
    private var startDigit = 0
    
    private var interstitialID = ct_Ads.interstitial_guessChallange
    
    private var rewardedAdService = RewardedAdService(advertisementID: ct_Ads.rewarded_guessStart)
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTargets()
        interstitial = createAndLoadInterstitial(advertisementID: interstitialID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromUserDefaults()
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - Helpers
    
    
    private func configureUI(){
        view.backgroundColor = ct_Color.pink
        view.addSubview(challangeStartView)
        challangeStartView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    private func getDataFromUserDefaults(){
        let defaults = UserDefaultsService.shared
        challangeStartView.recordView.number = defaults.getBestScore()
        challangeStartView.coinShowView.number = defaults.getCoin()
        challangeStartView.lastScoreView.number = defaults.getLastScore()
    }
    
    private func addTargets(){
        challangeStartView.playButton.addTarget(self, action: #selector(playClicked), for: .touchUpInside)
        challangeStartView.watchAdsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(watchAdsClicked)))
    }
    
    private func startChallange(startDigit:Int){
        let challangeController = ChallangeController()
        challangeController.guessService = GuessService(currentDigit: startDigit)
        navigationController?.pushViewController(challangeController, animated: true)
    }
    
    //MARK: - Selectors
    @objc private func playClicked(){
        var startDigitText = challangeStartView.startDigitView.numberTextField.text ?? "0"
        if startDigitText.isEmpty == true {startDigitText = "0"}
        
        let startDigit = Int(startDigitText) ?? -1
        
        if startDigit < 0 || startDigit >= 99_998{
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

extension ChallangeStartController:GADRewardedAdDelegate{
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        rewardedAdService.reloadRewardedAd()
        rewardedAdService.rewardedAdIsWatched { (newMoney) in
            challangeStartView.coinShowView.number = newMoney
        }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial(advertisementID: interstitialID)
        startChallange(startDigit: startDigit)
    }
    
    func showAds(){
        if interstitial.isReady{
            interstitial.present(fromRootViewController: self)
        }else{
            startChallange(startDigit: startDigit)
        }
    }
}
