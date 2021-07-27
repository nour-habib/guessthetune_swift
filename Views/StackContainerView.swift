//
//  StackContainerView.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-18.
//

import Foundation

class StackContainerView: UIView, SwipeCardDelegate

{
    
    var numOfCards: Int = 0
    var remainingCards: Int = 0
    
    var endGameLabel = UILabel(frame:CGRect(x:0,y:0,width:300,height:300))
    var scoreTextView = UITextView(frame: CGRect(x:20,y:65,width:100,height:27))
    
    var changeGenreButton = UIButton(frame:CGRect(x:260,y:60,width:100,height:50))

    var swipeCardViews: [SwipeCardView] = []
    
    var score: Int = 0
    var count: Int = 0
    
    var dataSource: SwipeCardViewDataSource?
    {
        didSet
        {
            reloadData()
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame:frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView()
    {
        scoreTextView.textColor = .white
        scoreTextView.font = UIFont(name:"HelveticaNeue-Bold", size:17)
        scoreTextView.isScrollEnabled = false
        scoreTextView.backgroundColor = .clear
        scoreTextView.text = String(getScore())
        addSubview(scoreTextView)
        
        changeGenreButton.setTitle("Change Genre", for: .normal)
        changeGenreButton.clipsToBounds = true
        changeGenreButton.titleLabel?.font =  UIFont(name:"HelveticaNeue-Bold", size:12)
        changeGenreButton.setTitleColor(.white, for: .normal)
        changeGenreButton.addTarget(self, action: #selector(resetTapped(_:)), for: .touchUpInside)
        addSubview(changeGenreButton)
        
    }
    
    @objc func resetTapped(_ sender:UIButton)
    {
        self.reloadData()
        let vc = GenreSelectionViewController()
        (superview?.next as? UIViewController)?.navigationController?.pushViewController(vc, animated: true)
        
        
    }
  
  

    func swipeDidEnd(on view: SwipeCardView)
    {
        //Update score
        scoreTextView.text = String(getScore())
    
        guard let datasource = dataSource else{return}
        view.removeFromSuperview()
        
        //Cards finished
        count = count + 1
        if(count==numOfCards)
        {
            endGameLabel.text = "Game finished! Score: " + String(getScore())
            endGameLabel.font = UIFont(name:"HelveticaNeue-Bold", size:20)
            endGameLabel.textColor = .black
            endGameLabel.center = view.center
            addSubview(endGameLabel)
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
        insertSubview(cardView, at: 0)
        remainingCards -= 1
    }
    
    private func removeAllCardViews()
    {
        for cardView in swipeCardViews
        {
            cardView.removeFromSuperview()
        }
        
        swipeCardViews = []
    }
    
    
}
