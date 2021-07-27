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
    
    var activityIndicator: UIActivityIndicatorView?

    var albumList: [Track] = []
    
    var gameQuestionsArr: [Question] = []
    var stackContainer = StackContainerView()
    
    override func loadView()
    {
        view = UIView()
        view.backgroundColor = .black
        gamePlayList.initializeGame(genre: genre)

        
        delayWithSeconds(2)
        {
            self.view.addSubview(self.stackContainer)
            self.configureStackContainer()
            self.stackContainer.translatesAutoresizingMaskIntoConstraints = false
            self.gameQuestionsArr = self.gamePlayList.newGame()
            self.stackContainer.dataSource = self
            
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ())
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds)
        {
            completion()
        }
    }
    
//    func startLoading()
//    {
//            activityIndicator = UIActivityIndicatorView()
//            activityIndicator?.center = self.view.center
//            activityIndicator?.hidesWhenStopped = true
//            activityIndicator?.style = UIActivityIndicatorView.Style.medium
//            activityIndicator?.color = .red
//        self.view.addSubview((activityIndicator)!)
//            activityIndicator?.startAnimating()
//                DispatchQueue.main.async {
//                if let activityIndicator = self.activityIndicator {
//                   self.view.addSubview(activityIndicator)
//                   activityIndicator.startAnimating()
//                }
//            }
            //UIApplication.shared.beginIgnoringInteractionEvents()
      //  }
    
//    func stopLoading()
//    {
//            DispatchQueue.main.async {
//                self.activityIndicator?.stopAnimating()
//                self.activityIndicator?.removeFromSuperview()
//                self.activityIndicator = nil
//            }
//            UIApplication.shared.endIgnoringInteractionEvents()
//        }
    
  
    

}

extension GameViewController: SwipeCardViewDataSource
{
    func numOfCards() -> Int
    {
        return gameQuestionsArr.count
    }
    
    func newCard(at index: Int) -> SwipeCardView
    {
        let gameCard = SwipeCardView(frame: CGRect(x:5,y:100,width:super.view.frame.width-10,height:super.view.frame.height-100))
        gameCard.dataSource = gameQuestionsArr[index]
        gameCard.configureView()
        
        return gameCard
        
    }
    func emptyView() -> UIView?
    {
        return nil
    }
    
    
    
    
}


