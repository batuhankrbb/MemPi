//
//  TrainingService.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation

class TrainingService{
    private let numbers = PI.PI_ARRAY
    
    var currentDigit:Int
    
    var numbersSoFar:[String]{
        var strForReturn = [String]()
        guard currentDigit != 0 else {return ["3","."]}
        strForReturn.append("3")
        strForReturn.append(".")
        for i in 0...currentDigit - 1{
            strForReturn.append(numbers[i])
        }
        return strForReturn
    }
    
    var isFinished:Bool{
        return currentDigit >= numbers.count - 3
    }
    

    init(currentDigit:Int) {
        self.currentDigit = currentDigit
    }
    
    func getNextNumber(completionHandler handler: (String,Int) -> Void){
        handler(numbers[currentDigit],Int(numbers[currentDigit + 1])!)
        currentDigit += 1
        return
    }
    
    
}
