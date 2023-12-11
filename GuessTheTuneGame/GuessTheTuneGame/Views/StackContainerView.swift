//
//  StackContainerView.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-01.
//

import UIKit

class StackContainerView: UIView, SwipeCardDelegate
{
    var numOfCards: Int = 0
    var remainingCards: Int = 0
    var score: Int = 0
    var count: Int = 0
    
    private var genre: String?
    private var endGameLabel: UILabel?
    private var scoreTextView: UITextView?
    private var titleTextView: UITextView?
    private var swipeTextView: UITextView?
    private var changeGenreButton: UIButton?
    
    var swipeCardViews = [SwipeCardView]()

    var dataSource: SwipeCardViewDataSource?
    {
        didSet
        {
            reloadData()
        }
    }
    
    init(genre: String)
    {
        self.genre = genre
        super.init(frame: .zero)
        backgroundColor = CustomColor.customGreen
        self.scoreTextView = UITextView(frame: .zero)
        self.changeGenreButton = UIButton(frame:.zero)
        self.titleTextView = UITextView(frame: .zero)
        self.swipeTextView = UITextView(frame: .zero)
        self.endGameLabel = UILabel(frame: .zero)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView()
    {
        if let scoreTextView = scoreTextView
        {
            scoreTextView.textColor = CustomColor.darkGray
            scoreTextView.font = UIFont(name:"HelveticaNeue-Bold", size:17)
            scoreTextView.isScrollEnabled = false
            scoreTextView.backgroundColor = .clear
            scoreTextView.text = String(getScore())
            addSubview(scoreTextView)
            
            scoreTextView.translatesAutoresizingMaskIntoConstraints = false
            scoreTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 25).isActive = true
            scoreTextView.topAnchor.constraint(equalTo: topAnchor, constant: 65).isActive = true
            scoreTextView.heightAnchor.constraint(equalToConstant: 27).isActive = true
            scoreTextView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        }
        
        if let changeGenreButton = changeGenreButton
        {
            changeGenreButton.setTitle("Change Genre", for: .normal)
            changeGenreButton.clipsToBounds = true
            changeGenreButton.titleLabel?.font =  UIFont(name:"HelveticaNeue-Bold", size:12)
            changeGenreButton.setTitleColor(CustomColor.darkGray, for: .normal)
            changeGenreButton.addTarget(self, action: #selector(resetTapped(_:)), for: .touchUpInside)
            addSubview(changeGenreButton)
            
            changeGenreButton.translatesAutoresizingMaskIntoConstraints = false
            changeGenreButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
            changeGenreButton.topAnchor.constraint(equalTo: topAnchor, constant: 65).isActive = true
            changeGenreButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            changeGenreButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        }
        
        if let titleTextView = titleTextView
        {
            titleTextView.textColor = CustomColor.darkGray
            titleTextView.font = UIFont(name:"HelveticaNeue-Bold", size:17)
            titleTextView.isScrollEnabled = false
            titleTextView.backgroundColor = .clear
            titleTextView.text = genre?.capitalized
            addSubview(titleTextView)
            
            titleTextView.translatesAutoresizingMaskIntoConstraints = false
            titleTextView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            titleTextView.topAnchor.constraint(equalTo: topAnchor, constant: 65).isActive = true
            titleTextView.heightAnchor.constraint(equalToConstant: 27).isActive = true
            titleTextView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        }
    }
    
    @objc func resetTapped(_ sender:UIButton)
    {
        print("change genre button pressed")
        self.reloadData()
        let vc = GenreSelectionViewController()
        (superview?.next as? UIViewController)?.navigationController?.pushViewController(vc, animated: true)
    }
  
    func swipeDidEnd(on view: SwipeCardView)
    {
        //Update score
        if let scoreTextView = scoreTextView
        {
            scoreTextView.text = String(getScore())
        }
    
        //guard let datasource = dataSource else{return}
        //view.removeFromSuperview()
        
        UIView.transition(with: view, duration: 1, options: [.transitionCrossDissolve], animations: {
          view.removeFromSuperview()
        }, completion: nil)
        
//        UIView.transition(with: view,
//                          duration: 3,
//            options: [.transitionCrossDissolve],
//            animations: {
//            view.removeFromSuperview()
//            }, completion: nil)

        
    
        //Cards finished
        count = count + 1
        if(count == numOfCards)
        {
            guard let endGameLabel = endGameLabel else {return}

            endGameLabel.text = "Game finished! Score: " + String(getScore())
            endGameLabel.font = UIFont(name:"HelveticaNeue-Bold", size:25)
            endGameLabel.textColor = .black
            endGameLabel.center = view.center
            endGameLabel.numberOfLines = 3
            addSubview(endGameLabel)
            
            endGameLabel.translatesAutoresizingMaskIntoConstraints = false
            endGameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            endGameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 65).isActive = true
            endGameLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
            endGameLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        }
    }
    
    func incrementScore()
    {
        score  = score + 500
    }
    
    func getScore() -> Int
    {
        return score
    }
    
    func reloadData()
    {
        removeAllCardViews()
        
        guard let datasource = dataSource else {return}
        setNeedsLayout()
        layoutIfNeeded()
        self.numOfCards = datasource.numOfCards()
        self.remainingCards = self.numOfCards
        
        for i in 0...numOfCards-1
        {
            let dc = datasource.newCard(at: i)
            addCardView(cardView: dc, atIndex: i)
        }
    }
    
    private func addCardView(cardView: SwipeCardView,atIndex index: Int)
    {
        
        cardView.delegate = self
        swipeCardViews.append(cardView)
        UIView.transition(with: cardView, duration: 1, options: [.transitionCrossDissolve], animations: {
            self.insertSubview(cardView, at: 0)
        }, completion: nil)
        remainingCards -= 1
    }
    
    private func removeAllCardViews()
    {
        for cardView in swipeCardViews
        {
            cardView.removeFromSuperview()
        }
        
        swipeCardViews = [SwipeCardView]()
    }
}
