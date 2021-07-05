//
//  MusicPlayer.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-13.
//

import Foundation
import AVFoundation


class MusicPlayerView: UIView
{
    var audioPlayer: AVPlayer?
    var playerItem: AVPlayerItem?
    
    var playButton: UIButton?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    
        configureView()
    }
    
    required init?(coder c: NSCoder)
    {
        fatalError("init(coder:) not implemented")
        
    }
    
    func setupPlayer(url: String)
    {
        if let play = audioPlayer
        {
            play.play()
        }
        else
        {
            audioPlayer = AVPlayer(url: (NSURL(string: url) )! as URL)
            audioPlayer?.play()
        }
        
    }
    
    func configureView()
    {
        
        playButton = UIButton(type: .custom)
        playButton?.frame = CGRect(x: 150, y: 420, width: 60, height: 60)
        playButton?.layer.cornerRadius = 0.5 * (playButton?.bounds.size.width)!
       
        playButton?.setImage(UIImage(systemName: "play"), for: .normal)
        playButton?.backgroundColor = CustomColor.spotifyColor
        playButton?.tintColor = .white
        playButton?.layer.borderColor = UIColor.white.cgColor
        playButton?.clipsToBounds = true
        self.addSubview(playButton!)
        
    }
    
    func stopPlayer()
    {
        if let play = audioPlayer
        {
            play.pause()
            audioPlayer = nil
        }
        else
        {
            print("player deallocated")
            
        }
    
    }
    
 
}
