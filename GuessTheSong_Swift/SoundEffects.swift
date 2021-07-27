//
//  SoundEffects.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-26.
//

import Foundation
import AVFoundation


class SoundEffects
{
    var player: AVAudioPlayer?
    
    init(){}
    
    private func playSound(type:String,ext:String) -> Void
    {
        guard let url = Bundle.main.url(forResource: type, withExtension: ext) else { return }

           do {
               try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
               try AVAudioSession.sharedInstance().setActive(true)

          
               player = try AVAudioPlayer(contentsOf: url, fileTypeHint: ext)

               /* iOS 10 and earlier require the following line:
               player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

               guard let player = player else { return }

               player.play()

           } catch let error {
               print(error.localizedDescription)
           }
    }
    
    func playAchievement() -> Void
    {
        playSound(type: "achievement",ext: "wav")
    }
    
    func playBubblePop() -> Void
    {
        playSound(type:"bubble_pop", ext:"mp3")
    }
}
