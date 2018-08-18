//
//  ViewController.swift
//  Deck of Cards
//
//  Created by Trent Hamilton on 6/2/18.
//  Copyright © 2018 aenemated interactive development, llc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = Deck()
    var hand: Hand?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func deal(_ sender: Any) {
        deck = Deck()
        deck.shuffle()

        hand = deck.deal(5)
        for card in hand!.cards {
            print("\(card.description) \(card.suit.description)")
        }
        print("\n")
    }

    @IBAction func draw(_ sender: Any) {
        guard
            let firstCard = hand?.cardAt(index: 0),
            let secondCard = hand?.cardAt(index: 4),
            let newCards = deck.deal(2)
        else { return }
        
        hand!.draw(replacing: [firstCard, secondCard], with: newCards)
        for card in hand!.cards {
            print("\(card.description) \(card.suit.description)")
        }
        print("\n")
    }
}

