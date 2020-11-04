//
//  CustomInterstitialController.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation

import UIKit
import GoogleMobileAds

protocol InterstitialAdProtocol{
    var interstitial:GADInterstitial! {get set}
}

class CustomInterstitialController:CustomViewController,InterstitialAdProtocol, GADInterstitialDelegate{
    
    var interstitial:GADInterstitial!
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Helpers
    
    func createAndLoadInterstitial(advertisementID:String) -> GADInterstitial{
        let interstitial = GADInterstitial(adUnitID: advertisementID)
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
}
