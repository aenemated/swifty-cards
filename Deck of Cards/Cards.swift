//
//  Cards.swift
//  Video Poker
//
//  Created by Trent Hamilton on 6/2/18.
//  Copyright © 2018 aenemated interactive development, llc. All rights reserved.
//

import Foundation

struct Card {
    var suit: Suit = .spade
    var value = 0
    var description: String {
        switch value {
        case 11: return "Jack"
        case 12: return "Queen"
        case 13: return "King"
        case 14: return "Ace"
        default: return "\(value)"
        }
    }
}

enum Suit: Int {
    case spade = 1, heart, diamond, club
    var description: String {
        switch self {
        case .spade: return "♠︎"
        case .heart: return "♥︎"
        case .diamond: return "♦︎"
        case .club: return "♣︎"
        }
    }
}

class Deck {

    var deck = [Card]() // Not private for testing purposes

    var cardsLeft: Int {
        return deck.count
    }

    init() {
        for i in 1 ... 4 { deck.append(contentsOf: suits(suit: Suit(rawValue: i)!)) }
    }

    private func suits(suit: Suit) -> [Card] {
        var cards = [Card]()
        for i in 2 ... 14 { cards.append(Card(suit: suit, value: i)) }
        return cards
    }

    func shuffle() {
        var results = [Card]()
        let indexes = (0 ..< deck.count).map { $0 }
        for _ in indexes {
            let randomIndex = Int(arc4random_uniform(UInt32(deck.count)))
            let index = indexes[randomIndex]
            results.append(deck[index])
            deck.remove(at: index)
        }
        deck = results
    }

    func deal(_ num: Int) -> Hand? {
        guard deck.count >= num else { return nil }

        var hand = [Card]()
        for _ in 0 ..< num {
            if let card = pop() {
                hand.append(card)
            }
        }
        
        return Hand(cards: hand)
    }

    private func pop() -> Card? {
        guard let card = deck.first else { return nil }
        deck.removeFirst()
        return card
    }
}

struct Hand {
    var cards = [Card]()
    var value: PokerHandType {
        return PokerHand(self).value
    }
    var highCard: Card {
        return cards.sorted(by: { $0.value > $1.value }).first!
    }

    func cardAt(index: Int) -> Card? {
        guard index < cards.count else { return nil }
        return cards[index]
    }

    mutating func draw(replacing: [Card], with: Hand) {
        guard replacing.count == with.cards.count else { return }
        for index in 0 ..< replacing.count {
            if let indexToReplace = popCard(replacing[index]) {
                cards.insert(with.cardAt(index: index)!, at: indexToReplace)
            }
        }
    }

    mutating func pushCard(_ card: Card) {
        cards.append(card)
    }

    mutating func popCard(_ card: Card) -> Int? {
        guard let index = cards.index(where: { $0.suit == card.suit && $0.value == card.value }) else { return nil }
        cards.remove(at: index)
        return index
    }
}
