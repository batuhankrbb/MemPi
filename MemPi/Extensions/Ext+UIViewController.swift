//
//  Ext+UIViewController.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit
import GoogleMobileAds

extension UIViewController{
    
    func showAlert(title:String = "Oops!",message:String = "Something went wrong"){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func popViewController(popViews: Int, animated: Bool = true) {
        if self.navigationController!.viewControllers.count > popViews
        {
            let vc = self.navigationController!.viewControllers[navigationController!.viewControllers.count - popViews - 1]
             self.navigationController?.popToViewController(vc, animated: animated)
        }
    }
    
    func shareScore(score:Int){
        let items:[Any] = ["I memorized \(score) digits of Pi! I think you can't break my record 😏 Let's play MemPi! \(URL(string: "https://apps.apple.com/us/app/mempi-memorize-pi-digits/id1538313631")!)"]
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityController.excludedActivityTypes = [.airDrop]
        
        if let popoverController = activityController.popoverPresentationController{
            popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
            popoverController.sourceView = self.view
            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        }
        present(activityController, animated: true)
    }
    
    func showCompleteAlert(title:String = "Congratulations", message:String = "You've memorized 100.000 Digits of Pi!!!!!"){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.navigationController?.popToRootViewController(animated: true)
            return
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoCoinAlert(error:MPError,adService:RewardedAdService,delegate: GADRewardedAdDelegate){
        let alert = UIAlertController(title: "Oh! Something's missing 🥺 You have \(UserDefaultsService.shared.getCoin()) coin", message: error.localizedDescription, preferredStyle: .alert)
        let cancelAnswer = UIAlertAction(title: "Not yet", style: .cancel, handler: nil)
        
        let okAnswer = UIAlertAction(title: "Of Course!", style: .default) { (action) in
            if adService.rewardedAd?.isReady == true {
                    adService.rewardedAd?.present(fromRootViewController: self, delegate:delegate)
                }else{
                    self.showAlert(title: "Oops!", message: "Advertisement is not ready for now. We are really sorry for that 😭 Please try again in a few minutes.")
            }
        }
        alert.addAction(okAnswer)
        alert.addAction(cancelAnswer)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func backToMenu(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    func getRating(){
        if #available( iOS 10.3,*){
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                if #available(iOS 14.0, *) {
                    SKStoreReviewController.requestReview(in: scene)
                } else {
                    SKStoreReviewController.requestReview()
                }
            }
        }
    }
}
