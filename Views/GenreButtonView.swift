//
//  GenreButtonView.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-11.
//

import Foundation

class GenreButtonView: UIView
{
    var selectedGenre = String()
    var soundEffects = SoundEffects()

    var rapButton = GenreButton(type:.custom)
    var rnbButton = GenreButton(type: .custom)
    var rockButton = GenreButton(type: .custom)
    var popButton = GenreButton(type: .custom)
    

    private var albumsArray: [Album] = []
    
    private let Game = GamePlaylist()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
      }
    
    required init?(coder c: NSCoder) {
        super.init(coder: c)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .black
    
        
        configureButtons()
        configureViews()
        
    }
    
    private func configureViews()
    {
        DispatchQueue.main.asyncAfter(deadline: .now()+2)
        {
            self.addSubview(self.rapButton)
            self.soundEffects.playBubblePop()
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3)
        {
            self.addSubview(self.rnbButton)
            self.soundEffects.playBubblePop()
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5)
        {
            self.addSubview(self.rockButton)
            self.soundEffects.playBubblePop()
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+7)
        {
            self.addSubview(self.popButton)
            self.soundEffects.playBubblePop()
            
        }
        
    }
    
    private func configureButtons()
    {
        
        rapButton.frame = CGRect(x: 145, y: 50, width: 100, height: 100)
        rapButton.layer.cornerRadius = 0.5 * (rapButton.bounds.size.width)
        rapButton.setTitle(Genre.rap.rawValue, for: .normal)
        
        
        rnbButton.frame = CGRect(x:145,y:180,width:100,height:100)
        rnbButton.layer.cornerRadius = 0.5 * (rnbButton.bounds.size.width)
        rnbButton.setTitle(Genre.rnb.rawValue,for:.normal)
        
        rockButton.frame = CGRect(x:145,y:310,width:100,height:100)
        rockButton.layer.cornerRadius = 0.5 * (rockButton.bounds.size.width)
        rockButton.setTitle(Genre.rock.rawValue, for: .normal)
        
        
        popButton.frame = CGRect(x:145,y:440,width:100,height:100)
        popButton.layer.cornerRadius = 0.5 * (popButton.bounds.size.width)
        popButton.setTitle(Genre.pop.rawValue, for: .normal)
        
        
    }
    

}
