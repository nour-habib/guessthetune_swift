//
//  SwipeCardViewDataSource.swift
//  GuessTheTuneGame
//
//  Created by Nour Habib on 2023-12-01.
//

import UIKit

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
