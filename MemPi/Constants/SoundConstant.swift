//
//  SoundConstant.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation

enum ct_Sound{
    static let buttonClickSound = URL(fileURLWithPath: Bundle.main.path(forResource: "buttonClickSound", ofType: "mp3")!)
    static let menuButtonClickSound = URL(fileURLWithPath: Bundle.main.path(forResource: "menuButtonClickSound", ofType: "wav")!)
}

enum Sounds{
    case buttonClick
    case menuButtonClick
}
