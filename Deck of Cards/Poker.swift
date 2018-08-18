//
//  Poker.swift
//  Video Poker
//
//  Created by Trent Hamilton on 6/2/18.
//  Copyright © 2018 aenemated interactive development, llc. All rights reserved.
//

import Foundation

enum PokerHandType {
    case highCard, pair, jacksOrBetter, twoPair, threeOfAKind, straight, flush, fullHouse, fourOfAKind, straightFlush, royalFlush
}

struct PokerHand {
    var value: PokerHandType = .highCard

    init(_ hand: Hand) {
        self.value = getHandValue(hand)
    }

    mutating func getHandValue(_ hand: Hand) -> PokerHandType {
        var value: PokerHandType = .highCard

        if isPair(hand)             { value = .pair }
        if isJacksOrBetter(hand)    { value = .jacksOrBetter }
        if isTwoPair(hand)          { value = .twoPair }
        if isThreeOfAKind(hand)     { value = .threeOfAKind }
        if isStraight(hand)         { value = .straight }
        if isFlush(hand)            { value = .flush }
        if isFullHouse(hand)        { value = .fullHouse }
        if isFourOfAKind(hand)      { value = .fourOfAKind }
        if isStraightFlush(hand)    { value = .straightFlush }
        if isRoyalFlush(hand)       { value = .royalFlush }

        return value
    }

    func isPair(_ hand: Hand) -> Bool {
        return numMatches(hand, num: 2).count == 2
    }

    func isJacksOrBetter(_ hand: Hand) -> Bool {
        let cards = numMatches(hand, num: 2)
        guard let value = cards.first?.value else { return false }
        return cards.count == 2 && value > 10
    }

    func isTwoPair(_ hand: Hand) -> Bool {
        let firstPair = numMatches(hand, num: 2)
        if let exclude = firstPair.first?.value {
            let secondPair = numMatches(hand, num: 2, exclude: exclude)
            return firstPair.count == 2 && secondPair.count == 2
        }
        return false
    }

    func isThreeOfAKind(_ hand: Hand) -> Bool {
        return numMatches(hand, num: 3).count == 3
    }

    func isStraight(_ hand: Hand) -> Bool {
        let sorted = hand.cards.sorted { $0.value < $1.value }

        guard var cardValue = sorted.first?.value else { return false }

        for i in 0 ..< sorted.count {
            let card = sorted[i]
            if card.value != cardValue {
                return false
            }
            cardValue += 1
        }
        return true
    }

    func isFlush(_ hand: Hand) -> Bool {
        if let firstSuit = hand.cards.first?.suit {
            let filtered = hand.cards.filter { $0.suit == firstSuit }
            return filtered.count == 5
        }
        return false
    }

    func isFullHouse(_ hand: Hand) -> Bool {
        return isPair(hand) && isThreeOfAKind(hand)
    }

    func isFourOfAKind(_ hand: Hand) -> Bool {
        return numMatches(hand, num: 4).count == 4
    }

    func isStraightFlush(_ hand: Hand) -> Bool {
        return isStraight(hand) && isFlush(hand)
    }

    func isRoyalFlush(_ hand: Hand) -> Bool {
        return isStraight(hand) && isFlush(hand) && hand.highCard.value == 14
    }

    // MARK: Helper
    func numMatches(_ hand: Hand, num: Int, exclude: Int = 0) -> [Card] {
        for card in hand.cards {
            let value = card.value
            if value == exclude { continue }
            
            let matches = hand.cards.filter { $0.value == value }
            if matches.count == num {
                return matches
            }
        }
        return [Card]()
    }
}
