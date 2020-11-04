//
//  GuessService.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import UIKit

class GuessService{
    private let numbers = PI.PI_ARRAY
    
    var currentDigit:Int
    
    var knownNumbers = 0
    
    var health = 3
    
    var numbersSoFar:[PiCollectionNumber]{
        var strForReturn = [PiCollectionNumber]()
        guard currentDigit != 0 else {return [PiCollectionNumber(number: "3"),PiCollectionNumber(number: ".")]}
        strForReturn.append(PiCollectionNumber(number: "3"))
        strForReturn.append(PiCollectionNumber(number: "."))
        for i in 0...currentDigit - 1{
            strForReturn.append(PiCollectionNumber(number: numbers[i]))
        }
        return strForReturn
    }
    
    var isFinished:Bool{
        return currentDigit >= numbers.count - 1
    }
    
    var hint:String{
        return Int(numbers[currentDigit]) ?? 0 < 5 ? "The next number is less than 5" : "The next number is 5 or more than 5"
    }
    
    var answer:Int{
        return Int(numbers[currentDigit]) ?? 0
    }
    
    init(currentDigit:Int) {
        self.currentDigit = currentDigit
    }
    
    func guessNext(number:Int,digit:Int, completionHandler handler: (GuessCases) -> Void){
        if Int(numbers[currentDigit])! == number{
            knownNumbers += 1
            currentDigit += 1
            handler(.correct)
            return
        }
        health -= 1
            if health <= 0{
                handler(.died(correctNum: numbers[currentDigit]))
                return
            }
        handler(.wrong(health: getHealthImage(health: health),correctNum: numbers[currentDigit]))
        currentDigit += 1
    }
    
    private func getHealthImage(health:Int) -> UIImage{
        switch health {
        case 1:
            return ct_Image.hearts1
        case 2:
            return ct_Image.hearts2
        default:
            return ct_Image.hearts3
        }
    }
}


enum GuessCases{
    case died(correctNum:String)
    case correct
    case wrong(health:UIImage,correctNum:String)
}

