//
//  Deck_of_CardsTests.swift
//  Deck of CardsTests
//
//  Created by Trent Hamilton on 6/2/18.
//  Copyright © 2018 aenemated interactive development, llc. All rights reserved.
//

import XCTest
@testable import Deck_of_Cards

class Deck_of_CardsTests: XCTestCase {

    func testDeckIS52Cards() {
        let deck = Deck()
        XCTAssertTrue(deck.deck.count == 52)
    }

    func testShuffle() {
        for _ in 1 ... 100000 { // This should fail if it doesn't work
            let deck = Deck()
            deck.shuffle()
            for card in deck.deck {
                let check = deck.deck.filter { $0.suit == card.suit && $0.value == card.value }
                if check.count > 1 {
                    XCTAssertTrue(false)
                }
            }
        }

        XCTAssertTrue(true)
    }

    func testIsHighCard() {

        var hand = Hand()

        let card1 = Card(suit: .spade, value: 2)
        hand.pushCard(card1)

        let card2 = Card(suit: .spade, value: 3)
        hand.pushCard(card2)

        let card3 = Card(suit: .spade, value: 7)
        hand.pushCard(card3)

        let card4 = Card(suit: .spade, value: 8)
        hand.pushCard(card4)

        let card5 = Card(suit: .heart, value: 12)
        hand.pushCard(card5)

        XCTAssertTrue(hand.value == .highCard, "Hand is not high card")
    }

    func testIsPair() {

        var hand = Hand()

        let card1 = Card(suit: .spade, value: 2)
        hand.pushCard(card1)

        let card2 = Card(suit: .spade, value: 2)
        hand.pushCard(card2)

        let card3 = Card(suit: .spade, value: 3)
        hand.pushCard(card3)

        let card4 = Card(suit: .spade, value: 4)
        hand.pushCard(card4)

        let card5 = Card(suit: .heart, value: 5)
        hand.pushCard(card5)

        XCTAssertTrue(hand.value == .pair, "Hand is not a pair")
    }

    func testIsJacksOrBetter() {

        var hand = Hand()

        let card1 = Card(suit: .spade, value: 9)
        hand.pushCard(card1)

        let card2 = Card(suit: .spade, value: 2)
        hand.pushCard(card2)

        let card3 = Card(suit: .spade, value: 3)
        hand.pushCard(card3)

        let card4 = Card(suit: .spade, value: 11)
        hand.pushCard(card4)

        let card5 = Card(suit: .heart, value: 11)
        hand.pushCard(card5)

        XCTAssertTrue(hand.value == .jacksOrBetter, "Hand is not jacks or better")
    }

    func testIsTwoPair() {

        var hand = Hand()

        let card1 = Card(suit: .spade, value: 2)
        hand.pushCard(card1)

        let card2 = Card(suit: .spade, value: 2)
        hand.pushCard(card2)

        let card3 = Card(suit: .spade, value: 3)
        hand.pushCard(card3)

        let card4 = Card(suit: .spade, value: 3)
        hand.pushCard(card4)

        let card5 = Card(suit: .heart, value: 5)
        hand.pushCard(card5)

        XCTAssertTrue(hand.value == .twoPair, "Hand is not two pair")
    }

    func testIsThreeOfAKind() {

        var hand = Hand()

        let card1 = Card(suit: .spade, value: 2)
        hand.pushCard(card1)

        let card2 = Card(suit: .spade, value: 5)
        hand.pushCard(card2)

        let card3 = Card(suit: .spade, value: 2)
        hand.pushCard(card3)

        let card4 = Card(suit: .spade, value: 3)
        hand.pushCard(card4)

        let card5 = Card(suit: .heart, value: 2)
        hand.pushCard(card5)

        XCTAssertTrue(hand.value == .threeOfAKind, "Hand is not three of a kind")
    }

    func testIsStraight() {

        var hand = Hand()

        let card1 = Card(suit: .spade, value: 2)
        hand.pushCard(card1)

        let card2 = Card(suit: .spade, value: 3)
        hand.pushCard(card2)

        let card3 = Card(suit: .spade, value: 4)
        hand.pushCard(card3)

        let card4 = Card(suit: .spade, value: 5)
        hand.pushCard(card4)

        let card5 = Card(suit: .heart, value: 6)
        hand.pushCard(card5)

        XCTAssertTrue(hand.value == .straight, "Hand is not a straight")
    }

    func testIsFourOfAKind() {

        var hand = Hand()

        let card1 = Card(suit: .spade, value: 2)
        hand.pushCard(card1)

        let card2 = Card(suit: .spade, value: 2)
        hand.pushCard(card2)

        let card3 = Card(suit: .spade, value: 2)
        hand.pushCard(card3)

        let card4 = Card(suit: .spade, value: 2)
        hand.pushCard(card4)

        let card5 = Card(suit: .heart, value: 6)
        hand.pushCard(card5)

        XCTAssertTrue(hand.value == .fourOfAKind, "Hand is not a four of a kind")
    }

    func testIsFlush() {

        var hand = Hand()

        let card1 = Card(suit: .spade, value: 2)
        hand.pushCard(card1)

        let card2 = Card(suit: .spade, value: 3)
        hand.pushCard(card2)

        let card3 = Card(suit: .spade, value: 4)
        hand.pushCard(card3)

        let card4 = Card(suit: .spade, value: 5)
        hand.pushCard(card4)

        let card5 = Card(suit: .spade, value: 7)
        hand.pushCard(card5)

        XCTAssertTrue(hand.value == .flush, "Hand is not a flush")
    }

    func testIsFullHouse() {

        var hand = Hand()

        let card1 = Card(suit: .spade, value: 2)
        hand.pushCard(card1)

        let card2 = Card(suit: .spade, value: 2)
        hand.pushCard(card2)

        let card3 = Card(suit: .spade, value: 2)
        hand.pushCard(card3)

        let card4 = Card(suit: .spade, value: 4)
        hand.pushCard(card4)

        let card5 = Card(suit: .spade, value: 4)
        hand.pushCard(card5)

        XCTAssertTrue(hand.value == .fullHouse, "Hand is not a full house")
    }

    func testIsStraightFlush() {

        var hand = Hand()

        let card1 = Card(suit: .spade, value: 1)
        hand.pushCard(card1)

        let card2 = Card(suit: .spade, value: 2)
        hand.pushCard(card2)

        let card3 = Card(suit: .spade, value: 3)
        hand.pushCard(card3)

        let card4 = Card(suit: .spade, value: 4)
        hand.pushCard(card4)

        let card5 = Card(suit: .spade, value: 5)
        hand.pushCard(card5)

        XCTAssertTrue(hand.value == .straightFlush, "Hand is not a straight flush")
    }

    func testIsRoyalFlush() {

        var hand = Hand()

        let card1 = Card(suit: .spade, value: 10)
        hand.pushCard(card1)

        let card2 = Card(suit: .spade, value: 11)
        hand.pushCard(card2)

        let card3 = Card(suit: .spade, value: 12)
        hand.pushCard(card3)

        let card4 = Card(suit: .spade, value: 13)
        hand.pushCard(card4)

        let card5 = Card(suit: .spade, value: 14)
        hand.pushCard(card5)

        XCTAssertTrue(hand.value == .royalFlush, "Hand is not a royal flush")
    }
}
