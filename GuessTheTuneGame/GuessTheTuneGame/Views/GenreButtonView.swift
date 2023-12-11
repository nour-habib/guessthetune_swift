//
//  EndGameView.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-01.
//

import UIKit
import Foundation

class GenreButtonView: UIView
{
    var rapButton: GenreButton?
    var rnbButton: GenreButton?
    var rockButton: GenreButton?
    var popButton: GenreButton?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.rapButton = GenreButton(frame: CGRect(x:center.x, y: center.y, width: 100, height: 100))
        self.rnbButton = GenreButton(frame: CGRect(x:center.x, y: center.y-100, width: 100, height: 100))
        self.rockButton = GenreButton(frame: CGRect(x:center.x, y: center.y-200, width: 100, height: 100))
        self.popButton = GenreButton(frame: CGRect(x:center.x, y: center.y-300, width: 100, height: 100))
        
        configureView()
    }
    
    required init?(coder c: NSCoder)
    {
        super.init(coder: c)
    }

    private func configureView()
    {
        backgroundColor = CustomColor.offWhite

        DispatchQueue.main.asyncAfter(deadline: .now()+1)
        {
            guard let rapButton = self.rapButton else {return}
            self.addSubview(rapButton)
            SoundEffects.playBubblePop()
            self.applyRapButtonConstraints()
            //rapButton.layer.cornerRadius = 0.5 * (rapButton.frame.height)
            rapButton.setTitle(Genre.rap.rawValue, for: .normal)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3)
        {
            guard let rnbButton = self.rnbButton else {return}
            self.addSubview(rnbButton)
            SoundEffects.playBubblePop()
            self.applyRnbButtonConstraints()
            rnbButton.layer.cornerRadius = 0.5 * (rnbButton.frame.height)
            rnbButton.setTitle(Genre.rnb.rawValue,for:.normal)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5)
        {
            guard let rockButton = self.rockButton else {return}
            self.addSubview(rockButton)
            SoundEffects.playBubblePop()
            self.applyRockButtonConstraints()
            rockButton.layer.cornerRadius = 0.5 * (rockButton.bounds.size.width)
            rockButton.setTitle(Genre.rock.rawValue, for: .normal)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+7)
        {
            guard let popButton = self.popButton else {return}
            self.addSubview(popButton)
            SoundEffects.playBubblePop()
            self.applyPopButtonConstraints()
            popButton.layer.cornerRadius = 0.5 * (popButton.bounds.size.width)
            popButton.setTitle(Genre.pop.rawValue, for: .normal)
        }
    }
    
    //MARK: Genre Button Constraints
    
    private func applyRapButtonConstraints()
    {
        guard let rapButton = rapButton else {return}
        
        rapButton.translatesAutoresizingMaskIntoConstraints = false
        rapButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        //rapButton.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        rapButton.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        rapButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        rapButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func applyRnbButtonConstraints()
    {
        guard let rnbButton = rnbButton,
              let rapButton = rapButton else {return}
        
        rnbButton.translatesAutoresizingMaskIntoConstraints = false
        rnbButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        rnbButton.topAnchor.constraint(equalTo: rapButton.bottomAnchor, constant: 0).isActive = true
        rnbButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        rnbButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func applyRockButtonConstraints()
    {
        guard let rockButton = rockButton,
              let rnbButton = rnbButton else {return}
        
        rockButton.translatesAutoresizingMaskIntoConstraints = false
        rockButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        rockButton.topAnchor.constraint(equalTo: rnbButton.bottomAnchor, constant: 0).isActive = true
        rockButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        rockButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func applyPopButtonConstraints()
    {
        guard let popButton = popButton,
              let rockButton = rockButton else {return}
        
        popButton.translatesAutoresizingMaskIntoConstraints = false
        popButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        popButton.topAnchor.constraint(equalTo: rockButton.bottomAnchor, constant: 0).isActive = true
        popButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        popButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

