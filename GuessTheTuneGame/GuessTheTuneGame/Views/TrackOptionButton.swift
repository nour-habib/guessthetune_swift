//
//  TrackOptionButton.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-01.
//

import UIKit

class TrackOptionButton: UIButton
{
    override init(frame: CGRect)
    {
        super.init(frame:frame)
        
        configureButton()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton()
    {
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = CustomColor.customGreen
        layer.cornerRadius = 20
        titleLabel?.numberOfLines = 2
        titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size:15)
    }
}
