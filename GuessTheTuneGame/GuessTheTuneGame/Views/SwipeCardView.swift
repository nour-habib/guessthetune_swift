//
//  SwipeCardView.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-01.
//

import UIKit

class SwipeCardView: UIView
{
    private var incorrectAnswerCount: Int = 0
    
    private var musicPlayerView: MusicPlayerView?
    private var trackOptionsView: TrackOptionsView?
    
    private var favButton: UIButton?
    private var gameTrack: Track?
    private var optsTrack: OptionTracks?
     
    var delegate: SwipeCardDelegate?
    var dataSource: Question?
    {
        didSet
        {
            self.gameTrack = dataSource?.mainTrack
            self.optsTrack = dataSource?.optionTracks
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.trackOptionsView = TrackOptionsView()
        self.musicPlayerView = MusicPlayerView()
        self.favButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView()
    {
        layer.cornerRadius = 15
        layer.borderWidth = 4
        layer.borderColor = CustomColor.customGreen.cgColor
        backgroundColor = CustomColor.offWhite
        
        isUserInteractionEnabled = true
        
        if let trackOptionsView = trackOptionsView
        {
            addSubview(trackOptionsView)
        }
        
        if let musicPlayerView = musicPlayerView
        {
            addSubview(musicPlayerView)
        }
        
        configureTrackOptionsView()
        configureMusicView()
        configureFavButton()
        addPanGestureOnCards()
    }
    
    private func configureMusicView()
    {
        guard let musicPlayerView = musicPlayerView else {return}

        musicPlayerView.playButton?.addTarget(self, action: #selector(playTrack), for: .touchUpInside)
        addSubview(musicPlayerView)
        
        musicPlayerView.translatesAutoresizingMaskIntoConstraints = false
        musicPlayerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100).isActive = true
        musicPlayerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        musicPlayerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        musicPlayerView.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    private func configureTrackOptionsView()
    {
        guard let trackOptionsView = trackOptionsView else {return}
        
        if let aButton = trackOptionsView.aButton
        {
            aButton.setTitle(self.optsTrack?.optA.name, for: .normal)
            aButton.addTarget(self, action: #selector(checkAnswer(_:)), for: .touchUpInside)
            aButton.addTarget(self, action: #selector(holdDown(_:)), for: .touchDown)
        }
       
        if let bButton = trackOptionsView.bButton
        {
            bButton.setTitle(self.optsTrack?.optB.name, for: .normal)
            bButton.addTarget(self, action: #selector(checkAnswer(_:)), for: .touchUpInside)
            bButton.addTarget(self, action: #selector(holdDown(_:)), for: .touchDown)
        }
        
        if let cButton = trackOptionsView.cButton
        {
            cButton.setTitle(self.optsTrack?.optC.name, for: .normal)
            cButton.addTarget(self, action: #selector(checkAnswer(_:)), for: .touchUpInside)
            cButton.addTarget(self, action: #selector(holdDown(_:)), for: .touchDown)
        }
        
        if let dButton = trackOptionsView.dButton
        {
            dButton.setTitle(self.optsTrack?.optD.name, for: .normal)
            dButton.addTarget(self, action: #selector(checkAnswer(_:)), for: .touchUpInside)
            dButton.addTarget(self, action: #selector(holdDown(_:)), for: .touchDown)
        }
        
        trackOptionsView.translatesAutoresizingMaskIntoConstraints = false
        trackOptionsView.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        trackOptionsView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        trackOptionsView.heightAnchor.constraint(equalToConstant: (255*4)+(15*3)).isActive = true
        trackOptionsView.widthAnchor.constraint(equalToConstant: 255).isActive = true
    }
    
    private func configureFavButton()
    {
        guard let favButton = favButton else {return}
        
        let favButtonConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .small)
        favButton.setImage(UIImage(systemName: "heart", withConfiguration: favButtonConfig), for:.normal)
        favButton.layer.cornerRadius = 0.5 * (favButton.bounds.size.width)
        favButton.backgroundColor = CustomColor.customGreen
        favButton.tintColor = .white

        favButton.addTarget(self,action: #selector(addToFav(_:)), for: .touchUpInside)
        
        addSubview(favButton)
        
        favButton.translatesAutoresizingMaskIntoConstraints = false
        favButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        favButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        favButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        favButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc
    func holdDown(_ sender:UIButton)
    {
        sender.backgroundColor = CustomColor.pastelOrange
    }
    
    @objc
    func checkAnswer(_ sender:UIButton)
    {
        if(sender.currentTitle == dataSource?.mainTrack?.name)
        {
            //Correct answer
            let card = self
            delegate?.incrementScore()
            if let musicPlayerView = musicPlayerView
            {
                musicPlayerView.stopPlayer()
            }
           
            SoundEffects.playAchievement()
            delegate?.swipeDidEnd(on: card)
        }
        else
        {
            sender.backgroundColor = .red
            incorrectAnswerCount = incorrectAnswerCount + 1
            if(incorrectAnswerCount == 3)
            {
                let card = self
                delegate?.swipeDidEnd(on: card)
                if let musicPlayerView = musicPlayerView
                {
                    musicPlayerView.stopPlayer()
                }
            }
        }
    }

    @objc
    func playTrack(_ sender:UIButton)
    {
        guard let gameTrack = gameTrack,
              let musicPlayerView = musicPlayerView else {return}

        print(gameTrack.name)
        
        if(musicPlayerView.playButton?.currentImage != (UIImage(systemName: "stop")))
        {
            musicPlayerView.setupPlayer(url: gameTrack.preview_url ?? "")
            musicPlayerView.playButton?.setImage(UIImage(systemName: "stop"), for: .normal)
        }
        else
        {
            musicPlayerView.stopPlayer()
            musicPlayerView.playButton?.setImage(UIImage(systemName: "play"), for: .normal)
        }
    }
    
    @objc
    func addToFav(_ sender: UIButton)
    {
        sender.backgroundColor = .red
        
        guard let mainTrack = dataSource?.mainTrack else {return}
        //CoreData_.saveItem(track: mainTrack)
        showAlert(title: "Saved", msg: "Track saved.")
    }
    
    private func showAlert(title: String, msg: String)
    {
        let alert = UIAlertController(title: title,message:msg,preferredStyle: .alert)
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        window?.rootViewController?.presentedViewController?.present(alert, animated: true, completion: nil)
        let time = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline:time)
        {
            alert.dismiss(animated: true, completion: nil)
            
        }
    }

    private func addPanGestureOnCards()
    {
          self.isUserInteractionEnabled = true
          addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer)
    {
        let card = sender.view as! SwipeCardView
        let point = sender.translation(in: self)
        
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        card.center = CGPoint(x: centerOfParentContainer.x + point.x, y: centerOfParentContainer.y + point.y)
//        let distanceFromCenter = ((UIScreen.main.bounds.width / 2) - card.center.x)
//        let divisor = ((UIScreen.main.bounds.width / 2) / 0.61)
               
                switch sender.state {
                case .ended:
                    if (card.center.x) > 400 {
                        delegate?.swipeDidEnd(on: card)
                        UIView.animate(withDuration: 0.2) {
                            card.center = CGPoint(x: centerOfParentContainer.x + point.x + 200, y: centerOfParentContainer.y + point.y + 75)
                            card.alpha = 0
                            self.layoutIfNeeded()
                        }
                        return
                    }else if card.center.x < -65 {
                        delegate?.swipeDidEnd(on: card)
                        UIView.animate(withDuration: 0.2) {
                            card.center = CGPoint(x: centerOfParentContainer.x + point.x - 200, y: centerOfParentContainer.y + point.y + 75)
                            card.alpha = 0
                            self.layoutIfNeeded()
                        }
                        return
                    }
                    UIView.animate(withDuration: 0.2) {
                        card.transform = .identity
                        card.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                        self.layoutIfNeeded()
                    }
                case .changed:
                    let rotation = tan(point.x / (self.frame.width * 2.0))
                    card.transform = CGAffineTransform(rotationAngle: rotation)
                    
                default:
                    break
                }
    }
    
}
