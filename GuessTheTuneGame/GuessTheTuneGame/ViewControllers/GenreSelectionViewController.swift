//
//  GenreSelectionViewController.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-08.
//

import UIKit

class GenreSelectionViewController: UIViewController
{
    private var genreButtonView: GenreButtonView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.genreButtonView = GenreButtonView()
        guard let genreButtonView = genreButtonView else {return}
        view.addSubview(genreButtonView)
        
        navigationController?.setToolbarHidden(true, animated: false);
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = CustomColor.offWhite
        
        configureButtons()
        applyGenreViewConstraints()
    }
    
    //MARK: Configure Genre Selection Buttons
    
    private func configureButtons()
    {
        guard let genreButtonView = genreButtonView else {return}
        
        guard let rapButton = genreButtonView.rapButton,
              let rnbButton = genreButtonView.rnbButton,
              let rockButton = genreButtonView.rockButton,
              let popButton = genreButtonView.popButton else {return}
        
        rapButton.addTarget(self, action: #selector(buttonSelected), for: .touchDown)
        rnbButton.addTarget(self, action: #selector(buttonSelected), for: .touchDown)
        rockButton.addTarget(self, action: #selector(buttonSelected), for: .touchDown)
        popButton.addTarget(self, action: #selector(buttonSelected), for: .touchDown)
        
        rapButton.addAction(UIAction{_ in
            self.selectGenre(genre: Genre.rap.rawValue)
        }, for: .touchUpInside)
        
        rnbButton.addAction(UIAction{_ in
            self.selectGenre(genre: Genre.rnb.rawValue)
        }, for: .touchUpInside)
        
        rockButton.addAction(UIAction{_ in
            self.selectGenre(genre: Genre.rock.rawValue)
        }, for: .touchUpInside)
        
        popButton.addAction(UIAction{_ in
            self.selectGenre(genre: Genre.pop.rawValue)
        }, for: .touchUpInside)
        
    }
    
    private func selectGenre(genre: String)
    {
        saveGenre(genre: genre)
        initializeTabBar(genre: genre)
    }
    
    @objc func buttonSelected(_ sender: UIButton)
    {
        sender.backgroundColor = CustomColor.pastelOrange
    }
    
    //MARK: UITabBarController Initialization
    
    private func initializeTabBar(genre:String)
    {
        let tabBar = UITabBarController()
        tabBar.tabBar.tintColor = CustomColor.pastelOrange
        tabBar.tabBar.barTintColor = .lightGray
        
        let gameViewController = UINavigationController(rootViewController: GameViewController(genre))
        let favsViewController = UINavigationController(rootViewController: FavouritesViewController())
        let settingsViewController = UINavigationController(rootViewController: SettingsViewController())
        
        tabBar.setViewControllers([gameViewController,favsViewController, settingsViewController], animated: false)
        
        guard let items = tabBar.tabBar.items else {return}
        
        let images = ["music.note","heart.fill","gear"]
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 60, weight: .light, scale: .medium)
        
        for x in 0..<items.count
        {
            items[x].image = UIImage(systemName: images[x], withConfiguration: symbolConfig)
        }
        
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar,animated:true)
    }
    
    private func applyGenreViewConstraints()
    {
        guard let genreButtonView = genreButtonView else {return}

        genreButtonView.translatesAutoresizingMaskIntoConstraints = false
        genreButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        genreButtonView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        genreButtonView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        genreButtonView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func saveGenre(genre: String)
    {
        if (UserDefaults.standard.bool(forKey: "app_previously_opened"))
        {
            let prev = UserDefaults.standard.string(forKey: "current_genre")
            UserDefaults.standard.set(prev,forKey:"previous_genre")
            
            UserDefaults.standard.set(genre,forKey:"current_genre")

        } else {
           UserDefaults.standard.set(true, forKey: "app_previously_opened")
           UserDefaults.standard.set(genre,forKey:"previous_genre")
        }
    }
}
