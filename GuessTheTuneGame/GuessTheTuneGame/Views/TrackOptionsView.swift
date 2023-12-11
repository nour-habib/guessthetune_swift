//
//  TrackOptionsView.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-01.
//

import UIKit

class TrackOptionsView: UIView
{
    var aButton: TrackOptionButton?
    var bButton: TrackOptionButton?
    var cButton: TrackOptionButton?
    var dButton: TrackOptionButton?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.aButton = TrackOptionButton()
        self.bButton = TrackOptionButton()
        self.cButton = TrackOptionButton()
        self.dButton = TrackOptionButton()
        
        configureView()
        configureTrackButtons()
        
      }
    
    required init?(coder c: NSCoder)
    {
        fatalError("init(coder:) not implemented")
        
    }
    
    private func configureView()
    {
        clipsToBounds = false
    }
    
    private func configureTrackButtons()
    {
        guard let aButton = aButton,
              let bButton = bButton,
              let cButton = cButton,
              let dButton = dButton else {return}
        
        addSubview(aButton)
        aButton.translatesAutoresizingMaskIntoConstraints = false
        aButton.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        aButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        aButton.widthAnchor.constraint(equalToConstant: 255).isActive = true
        
        addSubview(bButton)
        bButton.translatesAutoresizingMaskIntoConstraints = false
        bButton.topAnchor.constraint(equalTo: aButton.bottomAnchor, constant: 15).isActive = true
        bButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        bButton.widthAnchor.constraint(equalToConstant: 255).isActive = true
        
        addSubview(cButton)
        cButton.translatesAutoresizingMaskIntoConstraints = false
        cButton.topAnchor.constraint(equalTo: bButton.bottomAnchor, constant: 15).isActive = true
        cButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        cButton.widthAnchor.constraint(equalToConstant: 255).isActive = true
        
        addSubview(dButton)
        dButton.translatesAutoresizingMaskIntoConstraints = false
        dButton.topAnchor.constraint(equalTo: cButton.bottomAnchor, constant: 15).isActive = true
        dButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        dButton.widthAnchor.constraint(equalToConstant: 255).isActive = true
    }
}
