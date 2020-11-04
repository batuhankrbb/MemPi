//
//  PiCollectionNumber.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation

struct PiCollectionNumber{
    var number:String
    var isCorrect:Bool
    
    init(number:String,isCorrect:Bool = true) {
        self.number = number
        self.isCorrect = isCorrect
    }
}
