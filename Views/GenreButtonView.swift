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
    

    var rapButton = GenreButton(frame: CGRect(x: 90, y: 180, width: 100, height: 100))
    var rnbButton = GenreButton(frame: CGRect(x:190,y:180,width:100,height:100))
    var rockButton = GenreButton(frame: CGRect(x:90,y:280,width:100,height:100))
    var popButton = GenreButton(frame: CGRect(x:190,y:280,width:100,height:100))
    

    
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
        self.backgroundColor = .white
    
        
        configureButtons()
        configureViews()
        
    }
    
    private func configureViews()
    {
       
        self.addSubview(rapButton)
        self.addSubview(rnbButton)
        self.addSubview(rockButton)
        self.addSubview(popButton)
        
    }
    
    private func configureButtons()
    {
        rapButton.setTitle(Genre.rap.rawValue, for: .normal)
        rnbButton.setTitle(Genre.rnb.rawValue,for:.normal)
        rockButton.setTitle(Genre.rock.rawValue, for: .normal)
        popButton.setTitle(Genre.pop.rawValue, for: .normal)
        
        
    }
    

}
