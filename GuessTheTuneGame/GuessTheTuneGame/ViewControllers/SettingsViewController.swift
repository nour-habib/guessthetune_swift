//
//  SettingsViewController.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2023-09-11.
//

import UIKit

class SettingsViewController: UIViewController
{
    private var clearCacheButton: UIButton?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.offWhite
        title = "Settings"
        self.clearCacheButton = UIButton(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: 30))
        
        configureButton()
    }
    
    init()
    {
        super.init(nibName: nil,bundle: nil)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton()
    {
        guard let clearCacheButton = clearCacheButton else {return}

        clearCacheButton.backgroundColor = .lightGray
        clearCacheButton.setTitle("Clear cache", for: .normal)
        clearCacheButton.titleLabel?.textAlignment = .natural
        clearCacheButton.addTarget(self, action: #selector(clearCache(_:)), for: .touchUpInside)
        
        view.addSubview(clearCacheButton)
    }
    
    @objc func clearCache(_ sender:UIButton)
    {
        cache.removeAllCachedResponses()
        print("Cache cleared")
    }
}
