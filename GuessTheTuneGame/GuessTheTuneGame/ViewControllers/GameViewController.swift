//
//  GameViewController.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-13.
//

import UIKit

class GameViewController: UIViewController
{
    private var genre: String?
    private var gameQuestionsArr: [Question]?
    private var stackContainerView: StackContainerView?
    private var swipeTextView: UITextView?
    
    lazy var activityIndicator: UIActivityIndicatorView =
    {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.backgroundColor = .yellow
        return activityIndicator
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.backgroundColor = CustomColor.offWhite
        
        //Start game
        GamePlaylist.shared.initializeGame(genre: genre ?? "pop")
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

        //Replace with DispatchQueue
        delayWithSeconds(3)
        {
            guard let stackContainer = self.stackContainerView else {return}

            self.view.addSubview(stackContainer)
            self.configureStackContainer()
            self.gameQuestionsArr = GamePlaylist.shared.newGame()
            stackContainer.dataSource = self
            
            self.configureSwipeTextView()
            self.beginTextViewAnimation()
        }
    }
    
    init(_ genre: String)
    {
        self.genre = genre
        self.stackContainerView = StackContainerView(genre:genre)
        self.swipeTextView = UITextView()
        super.init(nibName: nil,bundle: nil)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStackContainer()
    {
        let screensize = UIScreen.main.bounds
        let w = screensize.width
        let h =  screensize.height
        
        guard let stackContainer = stackContainerView else {return}
        
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
        stackContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        stackContainer.widthAnchor.constraint(equalToConstant: w).isActive = true
        stackContainer.heightAnchor.constraint(equalToConstant: h).isActive = true
    }
    
    private func configureSwipeTextView()
    {
        guard let swipeTextView = swipeTextView else {return}

        swipeTextView.textColor = CustomColor.darkGray
        swipeTextView.font = UIFont(name:"HelveticaNeue-Bold", size:14)
        swipeTextView.isScrollEnabled = false
        swipeTextView.backgroundColor = .clear
        swipeTextView.text = "Swipe right to skip ->"
    }
    
    private func applyTextViewConstraints()
    {
        guard let swipeTextView = swipeTextView else {return}
        
        swipeTextView.translatesAutoresizingMaskIntoConstraints = false
        swipeTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        swipeTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        swipeTextView.heightAnchor.constraint(equalToConstant: 27).isActive = true
        swipeTextView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ())
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds)
        {
            completion()
        }
    }
    
    private func beginTextViewAnimation()
    {
        guard let swipeTextView = swipeTextView else {return}

        delayWithSeconds(2)
        {
            self.view.addSubview(swipeTextView)
            self.applyTextViewConstraints()
            SoundEffects.playBubblePop()
        }
        
        delayWithSeconds(5)
        {
            swipeTextView.alpha = 0
            SoundEffects.playBubblePop()
        }
    }
}

extension GameViewController: SwipeCardViewDataSource
{
    func numOfCards() -> Int
    {
        guard let gameQuestionsArr = gameQuestionsArr else {return 0}

        return gameQuestionsArr.count
    }
    
    func newCard(at index: Int) -> SwipeCardView
    {
        
        let gameCard = SwipeCardView(frame: CGRect(x:5,y:100,width:super.view.frame.width-10,height:super.view.frame.height-215))
        
        guard let gameQuestionsArr = gameQuestionsArr else {return SwipeCardView()}
        
        gameCard.dataSource = gameQuestionsArr[index]
        gameCard.configureView()
        
        return gameCard
    }
    
    func emptyView() -> UIView?
    {
        return nil
    }
}


