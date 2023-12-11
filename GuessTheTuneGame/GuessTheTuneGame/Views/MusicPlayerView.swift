//
//  MusicPlayerView.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-01.
//

import UIKit
import AVFoundation

class MusicPlayerView: UIView
{
    private var audioPlayer: AVPlayer?
    private var playerItem: AVPlayerItem?
    var playButton: UIButton?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.playButton = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        configureView()
    }
    
    required init?(coder c: NSCoder)
    {
        fatalError("init(coder:) not implemented")
        
    }
    
    private func configureView()
    {
        guard let playButton = playButton else {return}

        playButton.layer.cornerRadius = 0.5 * (playButton.bounds.size.width)
        let playButtonConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .small)
        playButton.setImage(UIImage(systemName: "play", withConfiguration: playButtonConfig), for: .normal)
        playButton.backgroundColor = CustomColor.customGreen
        playButton.tintColor = .white
        playButton.layer.borderColor = UIColor.white.cgColor
        playButton.clipsToBounds = true
        
        addSubview(playButton)
    }
    
    func setupPlayer(url: String)
    {
        if let play = audioPlayer
        {
            play.play()
        }
        else
        {
            guard let newURL = URL(string:url) else {return}
            audioPlayer = AVPlayer(url: newURL)
            audioPlayer?.play()
        }
    }
    
    func stopPlayer()
    {
        if let play = audioPlayer
        {
            play.pause()
            audioPlayer = nil
        }
    }
}
