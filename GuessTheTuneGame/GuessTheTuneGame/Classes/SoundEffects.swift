//
//  SoundEffects.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-01.
//

import Foundation
import AVFoundation

class SoundEffects
{
    private static func playSound(type:String,ext:String) -> Void
    {
        guard let url = Bundle.main.url(forResource: type, withExtension: ext) else { return }

           do {
               try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
               try AVAudioSession.sharedInstance().setActive(true)

               let player = try AVAudioPlayer(contentsOf: url, fileTypeHint: ext)
               player.play()

           } catch let error {
               print(error.localizedDescription)
           }
    }
    
    static func playAchievement() -> Void
    {
        playSound(type: "achievement",ext: "wav")
    }
    
    static func playBubblePop() -> Void
    {
        playSound(type:"bubble_pop", ext:"mp3")
    }
}
