//
//  UserDefaultsService.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation

class UserDefaultsService{
    static let shared = UserDefaultsService()
    
    private let defaultsStandart = UserDefaults.standard
    
    
    //MARK: - Coin
    func increaseCoin(key:String = "Coin",coinToIncrease coin:Int){
        guard coin > 0 else {return}
        let oldCoin = defaultsStandart.integer(forKey: key)
        let updatedCoin = oldCoin + coin
        defaultsStandart.setValue(updatedCoin, forKey: key)
    }
    
    func decreaseCoin(key:String = "Coin",coinToDecrease coin:Int,completionHandler handler: (MPError?) -> Void){
        let oldCoin = defaultsStandart.integer(forKey: key)
        let updatedCoin = oldCoin - coin
        if updatedCoin < 0{
            handler(.notEnoughCoin)
            return
        }
        defaultsStandart.setValue(updatedCoin, forKey: key)
        handler(nil)
    }
    
    func getCoin(key:String = "Coin") -> Int{
        return defaultsStandart.integer(forKey: key)
    }
    
    func setBestScore(score:Int,key:String = "BestScore"){
        if score > getBestScore(){
            defaultsStandart.setValue(score, forKey: key)
        }
    }
    
    //MARK: - Score
    
    func getBestScore(key:String = "BestScore") -> Int{
        return defaultsStandart.integer(forKey: key)
    }
    
    func getLastScore(key:String = "LastScore") -> Int{
        return defaultsStandart.integer(forKey: key)
    }
    
    func setLastScore(score:Int,key:String = "LastScore"){
        defaultsStandart.setValue(score, forKey: key)
    }
    
    //MARK: - Pi
    
    private func getPiNumbers(key:String = "PiNumber") -> [String]{
        if defaultsStandart.stringArray(forKey: key) == nil{
            setPiNumbers()
        }
        return defaultsStandart.stringArray(forKey: key) ?? []
    }
    
    func setPiNumbers(key:String = "PiNumber"){
        if defaultsStandart.stringArray(forKey: key) == nil{
            let array = PI.PI_NUMBER.map {String($0)}
            defaultsStandart.setValue(array, forKey: key)
            PI.PI_ARRAY = array
        }else{
            PI.PI_ARRAY = getPiNumbers()
        }
    }
    
    //MARK: - Ratings
    
    func updateReviewCount(key:String = "ReviewCount",completionHandler handler: (Bool) -> Void){
        var newReviewCount = defaultsStandart.integer(forKey: key) + 1
        if newReviewCount > 4{
            newReviewCount = 0
            handler(true)
        }else{
            handler(false)
        }
        defaultsStandart.setValue(newReviewCount, forKey: key)
    }
}
