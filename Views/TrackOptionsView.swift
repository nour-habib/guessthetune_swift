//
//  TrackOptionsView.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-14.
//

import Foundation

class TrackOptionsView: UIView
{
   
    var aButton = TrackOptionButton(frame: CGRect(x: 60, y: 110, width: 255, height: 60))
    var bButton = TrackOptionButton(frame: CGRect(x: 60, y: 175, width: 255, height: 60))
    var cButton = TrackOptionButton(frame: CGRect(x: 60, y: 240, width: 255, height: 60))
    var dButton = TrackOptionButton(frame: CGRect(x: 60, y: 305, width: 255, height: 60))
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        configureView()
        
      }
    
    required init?(coder c: NSCoder)
    {
        fatalError("init(coder:) not implemented")
        
    }
    
    private func configureView()
    {
        self.clipsToBounds = false
        
    }
 
}
