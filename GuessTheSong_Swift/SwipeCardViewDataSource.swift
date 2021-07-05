//
//  SwipeCardViewDataSource.swift
//  GuessTheSong_Swift
//
//  Created by Nour Habib on 2021-06-13.
//

import Foundation

protocol SwipeCardViewDataSource
{
    func numOfCards() -> Int
    func newCard(at index: Int) -> SwipeCardView
    func emptyView() -> UIView?
    
}

protocol SwipeCardDelegate
{
    func swipeDidEnd(on view: SwipeCardView)
    func incrementScore()
    func getScore() -> Int
}
