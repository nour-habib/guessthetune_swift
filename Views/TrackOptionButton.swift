//
//  TrackOptionButtons.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-14.
//

import Foundation

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
        self.setTitleColor(UIColor.black, for: .normal)
        self.backgroundColor = CustomColor.spotifyColor
        self.layer.cornerRadius = 20
        self.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size:15)
    }
}
