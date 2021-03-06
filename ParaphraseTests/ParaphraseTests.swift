//
//  ParaphraseTests.swift
//  ParaphraseTests
//
//  Created by Luke Lazzaro on 3/1/22.
//  Copyright © 2022 Hacking with Swift. All rights reserved.
//

import XCTest
@testable import Paraphrase

class ParaphraseTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // We made this test because we need to decouple some of the data logic in QuotesViewController and add it to a dedicated data model (QuotesModel).
    // The concept seems to be that if you can't get information about the data directly from the data model, something's gone wrong. A test that only uses the data model is a great way to test that.
    func testLoadingInitialQuotes() {
        let model = QuotesModel(testing: true)
        XCTAssert(model.count == 12)
    }
    
    // This is another test that helps decouple data logic from a view controller.
    func testRandomQuote() {
        let model = QuotesModel(testing: true)
        
        guard let quote = model.random() else {
            XCTFail()
            return
        }
        
        XCTAssert(quote.author == "Eliot")
    }
    
    func testFormatting() {
        let model = QuotesModel(testing: true)
        let quote = model.quote(at: 0)
        
        let testString = "\"\(quote.text)\"\n   — \(quote.author)"
        XCTAssert(quote.multiline == testString)
    }
    
    func testAddingQuote() {
        var model = QuotesModel(testing: true)
        let quoteCount = model.count
        
        let newQuote = Quote(author: "Paul Hudson", text: "Programming is an art. Don't spend all your time sharpening your pencil when you should be drawing.")
        model.add(newQuote)
        
        XCTAssert(model.count == quoteCount + 1)
    }
    
    func testRemovingQuote() {
        var model = QuotesModel(testing: true)
        let quoteCount = model.count
        
        model.remove(at: 0)
        XCTAssert(model.count == quoteCount - 1)
    }
    
    func testReplacingQuote() {
        var model = QuotesModel(testing: true)
        
        let newQuote = Quote(author: "Ted Logan", text: "All we are is dust in the wind, dude.")
        model.replace(index: 0, with: newQuote)
        
        let testQuote = model.quote(at: 0)
        XCTAssert(testQuote.author == "Ted Logan")
    }
    
    func testReplacingEmptyQuote() {
        var model = QuotesModel(testing: true)
        let previousCount = model.count
        
        let newQuote = Quote(author: "", text: "")
        model.replace(index: 0, with: newQuote)
        
        XCTAssert(model.count == previousCount - 1)
    }

}
