//
//  SwipeCard.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-13.
//

import Foundation


class SwipeCardView: UIView
{
    
    var delegate: SwipeCardDelegate?
    
    var musicPlayerView = MusicPlayerView()
    var trackOptionsView = TrackOptionsView()
    
    var favButton = UIButton(type:.custom)
    var infoButton = UIButton(frame: CGRect(x:10,y:10,width:30,height:30))
    
    var gameTrack: Track!
    var optsTrack: OptionTracks?
    
    var divisor : CGFloat = 0
    
    var soundEffects = SoundEffects()
    
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
        self.isUserInteractionEnabled = true
        
    
    
        configureView()
        
      }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureView()
    {
        //print("configureView()")
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = CustomColor.spotifyColor.cgColor
        self.backgroundColor = .black
        
        
        self.isUserInteractionEnabled = true
        
        self.addSubview(trackOptionsView)
        self.addSubview(musicPlayerView)
    
        configureButtons()
        addPanGestureOnCards()
        configureTapGesture()
        
    }
    
    func configureButtons()
    {
        self.addSubview(trackOptionsView.aButton)
        self.addSubview(trackOptionsView.bButton)
        self.addSubview(trackOptionsView.cButton)
        self.addSubview(trackOptionsView.dButton)
        
        
        self.addSubview((musicPlayerView.playButton)!)
        self.addSubview(favButton)
        

        trackOptionsView.aButton.setTitle(self.optsTrack?.optA.name, for: .normal)
        trackOptionsView.bButton.setTitle(self.optsTrack?.optB.name, for: .normal)
        trackOptionsView.cButton.setTitle(self.optsTrack?.optC.name, for: .normal)
        trackOptionsView.dButton.setTitle(self.optsTrack?.optD.name, for: .normal)
        
        trackOptionsView.aButton.addTarget(self, action: #selector(checkAnswer(_:)), for: .touchUpInside)
        trackOptionsView.aButton.addTarget(self, action: #selector(holdDown(_:)), for: .touchDown)
        trackOptionsView.bButton.addTarget(self, action: #selector(checkAnswer(_:)), for: .touchUpInside)
        trackOptionsView.bButton.addTarget(self, action: #selector(holdDown(_:)), for: .touchDown)
        trackOptionsView.cButton.addTarget(self, action: #selector(checkAnswer(_:)), for: .touchUpInside)
        trackOptionsView.cButton.addTarget(self, action: #selector(holdDown(_:)), for: .touchDown)
        trackOptionsView.dButton.addTarget(self, action: #selector(checkAnswer(_:)), for: .touchUpInside)
        trackOptionsView.dButton.addTarget(self, action: #selector(holdDown(_:)), for: .touchDown)
        
        musicPlayerView.playButton?.addTarget(self, action: #selector(playF), for: .touchUpInside)

       
        favButton.setImage(UIImage(systemName: "heart"), for:.normal)
        favButton.frame = CGRect(x: frame.width-55, y: 18, width: 40, height: 40)
        favButton.layer.cornerRadius = 0.5 * (favButton.bounds.size.width)
        favButton.backgroundColor = CustomColor.spotifyColor
        favButton.tintColor = .white

        favButton.addTarget(self,action: #selector(addToFav(_:)), for: .touchUpInside)
    
    }
    
    @objc
    func holdDown(_ sender:UIButton)
    {
        sender.backgroundColor = UIColor.white
    }
    @objc
    func checkAnswer(_ sender:UIButton)
    {
        if(sender.currentTitle == dataSource?.mainTrack?.name)
        {
            let card = self
            
            delegate?.incrementScore()
            
            musicPlayerView.stopPlayer()
            soundEffects.playAchievement()
            
        
            delegate?.swipeDidEnd(on: card)
            
        }
        else
        {
            
            sender.backgroundColor = .red
        }
    }

    @objc
    func playF(_ sender:UIButton)
    {
        print(self.gameTrack.name)
    
        
        if(musicPlayerView.playButton?.currentImage == (UIImage(systemName: "play")))
        {
            
            musicPlayerView.setupPlayer(url: self.gameTrack.preview_url ?? "")
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
        CoreData_.createItem(track: (dataSource?.mainTrack)!)
        showAlert(title: "Saved", msg: "Track saved.")
        
    }
    
    func showAlert(title: String, msg: String)
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

    
    func configureTapGesture()
    {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
    }
    
    func addPanGestureOnCards()
    
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
        let distanceFromCenter = ((UIScreen.main.bounds.width / 2) - card.center.x)
        divisor = ((UIScreen.main.bounds.width / 2) / 0.61)
               
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
    
    @objc func handleTapGesture(sender: UITapGestureRecognizer)
    {
    }
    
   
    
   
    
      
}
