//
//  GenreSelectionViewController.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-08.
//

import UIKit

class GenreSelectionViewController: UIViewController{

    
    var selectedGenre = String()
    var genreButtonView: GenreButtonView!


    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
        genreButtonView = GenreButtonView()
       genreButtonView.frame = view.bounds
    
        self.view.addSubview(genreButtonView)
        self.navigationController?.setToolbarHidden(true, animated: false);
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        genreButtonView.rapButton.addTarget(self, action: #selector(selectRap(_:)), for: .touchUpInside)
        genreButtonView.rnbButton.addTarget(self, action: #selector(selectRnb(_:)), for: .touchUpInside)
        genreButtonView.rockButton.addTarget(self, action: #selector(selectRock(_:)), for: .touchUpInside)
        genreButtonView.popButton.addTarget(self, action: #selector(selectPop(_:)), for: .touchUpInside)
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func selectRap(_ sender:UIButton)
    {
        start(genre:"rap")
    }
    
    @objc func selectRnb(_ sender:UIButton)
    {
        start(genre:"rnb")
    }
    
    @objc func selectRock(_ sender:UIButton)
    {
        start(genre:"rock")
    }
    
    @objc func selectPop(_ sender:UIButton)
    {
        start(genre:"pop")
    }
    
    
    func start(genre: String)
    {
        initializeTabBar(genre: genre)
    }
    
    func initializeTabBar(genre:String)
    {
        let tabBar = UITabBarController()
        
        let gameViewController = UINavigationController(rootViewController: GameViewController(genre))
        let favsViewController = UINavigationController(rootViewController: FavouritesViewController())
        
        gameViewController.title = "Game"
        favsViewController.title = "Favs"
        
        tabBar.setViewControllers([gameViewController,favsViewController], animated: false)
        
        guard let items = tabBar.tabBar.items else
        {
            return
        }
        
        let images = ["play","heart"]
        for x in 0..<items.count
        {
            items[x].image = UIImage(systemName: images[x])
        }
        
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar,animated:true)
    }
   

}
