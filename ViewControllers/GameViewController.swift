//
//  GameViewController.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-13.
//

import UIKit

class GameViewController: UIViewController {

    let genre: String
    private lazy var gamePlayList =  GamePlaylist()
    
    
    var albumList: [Track] = []
    
    var gameQuestionsArr: [Question] = []
    //var stackContainer: StackContainerView!
    var stackContainer = StackContainerView()
    
    override func loadView()
    {
        view = UIView()
        view.backgroundColor = .white
        
        gamePlayList.initializeGame(genre: genre)
        
        delayWithSeconds(5)
        {
            self.view.addSubview(self.stackContainer)
            self.configureStackContainer()
            self.configureNavigationBarButtonItem()
            self.stackContainer.translatesAutoresizingMaskIntoConstraints = false
            self.gameQuestionsArr = self.gamePlayList.newGame()
            self.stackContainer.dataSource = self
            
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    init(_ genre: String)
    {
        self.genre = genre
        super.init(nibName: nil,bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureStackContainer()
    {
        let screensize = UIScreen.main.bounds
        let w = screensize.width
        let h =  screensize.height
        
        stackContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        stackContainer.widthAnchor.constraint(equalToConstant: w).isActive = true
        stackContainer.heightAnchor.constraint(equalToConstant: h).isActive = true
    }
    
    func configureNavigationBarButtonItem()
    {
        
        let changeGenres = UIButton()
        changeGenres.setTitle("Change Genre", for: .normal)
        changeGenres.clipsToBounds = true
        changeGenres.titleLabel?.font =  UIFont(name:"HelveticaNeue", size:12)
        changeGenres.setTitleColor(.black, for: .normal)
        changeGenres.addTarget(self, action: #selector(resetTapped(_:)), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView:changeGenres)
         
    }
    
    @objc func resetTapped(_ sender:UIButton)
    {
        stackContainer.reloadData()
        let vc = GenreSelectionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ())
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds)
        {
            completion()
        }
    }
    
    
    //implement alerts
    func alert()
    {
        let alert = UIAlertController(title: "Saved",message:"Added to favs",preferredStyle: .alert)
        present(alert,animated:true)
    }
    

}

extension GameViewController: SwipeCardViewDataSource
{
    func numOfCards() -> Int
    {
        return gameQuestionsArr.count
    }
    
    func newCard(at index: Int) -> SwipeCardView
    {
        let gameCard = SwipeCardView(frame: CGRect(x:5,y:150,width:super.view.frame.width-10,height:super.view.frame.height-150))
        gameCard.dataSource = gameQuestionsArr[index]
        gameCard.configureView()
        
        return gameCard
        
    }
    func emptyView() -> UIView?
    {
        return nil
    }
    
    
}


