//
//  GenreButton.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-01.
//

import Foundation
import UIKit

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
        setTitleColor(UIColor.black, for: .normal)
        backgroundColor = CustomColor.customGreen
        titleLabel?.font =  UIFont(name:"HelveticaNeue-Bold", size:20)
        setTitleColor(.white, for: .normal)
        layer.borderWidth = 1
        //layer.cornerRadius = 20
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 0.5 * (bounds.size.width)
        clipsToBounds = true
    }
}
