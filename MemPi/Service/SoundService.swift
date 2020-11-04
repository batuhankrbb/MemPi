//
//  SoundService.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation
import AVFoundation

class SoundService{
    
    private var player = AVAudioPlayer()
    
    var isSoundOn = true
    
    private init() {}
    
    static var shared = SoundService()
    
     func playSound(sound:Sounds){
        guard isSoundOn == true else {return}
        do{
            switch sound {
            case .buttonClick:
                player = try AVAudioPlayer(contentsOf: ct_Sound.buttonClickSound)
            case .menuButtonClick:
                player = try AVAudioPlayer(contentsOf: ct_Sound.menuButtonClickSound)
            }
            player.play()
        }catch{
            print("Error in SoundService")
        }
    }
}
