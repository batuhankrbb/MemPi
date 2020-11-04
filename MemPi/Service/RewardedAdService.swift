//
//  RewardedAdService.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import GoogleMobileAds

class RewardedAdService{
    
    private var advertisementID:String
    
    var rewardedAd: GADRewardedAd!

    init(advertisementID:String) {
        self.advertisementID = advertisementID
        reloadRewardedAd()
    }
    
    private func createAndLoadRewardedAd() -> GADRewardedAd?{
      rewardedAd = GADRewardedAd(adUnitID: advertisementID)
      rewardedAd.load(GADRequest()) { error in
        if let error = error {
          print("Loading failed: \(error)")
        } else {
          print("Loading Succeeded")
        }
      }
      return rewardedAd
    }

    func reloadRewardedAd(){
        rewardedAd = createAndLoadRewardedAd()
    }
    
    func rewardedAdIsWatched(completionHandler handler: (Int) -> Void){
        UserDefaultsService.shared.increaseCoin(coinToIncrease: 30)
        handler(UserDefaultsService.shared.getCoin())
    }
}
