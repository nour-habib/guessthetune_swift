//
//  GenreButton.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-11.
//

import Foundation

class GenreButton: UIButton
{
    
    override init(frame: CGRect)
    {
        super.init(frame:frame)
        
        setupButton()
        
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton()
    {

        self.setTitleColor(UIColor.black, for: .normal)
        self.backgroundColor = CustomColor.spotifyColor
        self.titleLabel?.font =  UIFont(name:"HelveticaNeue-Bold", size:20)
        self.setTitleColor(.white, for: .normal)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 20
        
    }

}
