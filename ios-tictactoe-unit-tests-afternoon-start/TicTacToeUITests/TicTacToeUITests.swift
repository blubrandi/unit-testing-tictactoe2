//
//  TicTacToeUITests.swift
//  TicTacToeUITests
//
//  Created by Brandi Bailey on 12/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import XCTest

class TicTacToeUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        XCUIApplication().launch()
    }
    
    func testWinCheckingVertical1() {
        /*
         0 1 2
         3 4 5
         6 7 8
         */
        
        /*
         x o -
         x o -
         x - -
         */
        
        
        let button0 = button(forIndex: 0)
        let button1 = button(forIndex: 1)
        let button3 = button(forIndex: 3)
        let button4 = button(forIndex: 4)
        let button6 = button(forIndex: 6)
        
        button0.tap()
        XCTAssertEqual(button0.label, "X")
        XCTAssertEqual(turnLabel.label, "Player O's turn")
        
        button1.tap()
        XCTAssertEqual(button1.label, "O")
        XCTAssertEqual(turnLabel.label, "Player X's turn")
        
        button3.tap()
        XCTAssertEqual(button3.label, "X")
        XCTAssertEqual(turnLabel.label, "Player O's turn")
        
        button4.tap()
        XCTAssertEqual(button4.label, "O")
        XCTAssertEqual(turnLabel.label, "Player X's turn")
        
        button6.tap()
        XCTAssertEqual(button6.label, "X")
        XCTAssertEqual(turnLabel.label, "Player X won!")
        
    }
    
    func testRestartingGame() {
        // Tap someplace in the board so it isn't empty
        let button4 = button(forIndex: 4)
        button4.tap()
        
        // Make sure the board has been marked
        XCTAssertEqual(button4.label, "X")
        
        // Check the next player's turn label
        XCTAssertEqual(turnLabel.label, "Player O's turn")
        
        // Make sure the board is empty again
        restartButton.tap()
        
        for i in 0...8 {
            XCTAssertEqual(button(forIndex: i).label, " ")
        }
    }
    
    /////////////
    // Test Example of async ui code
    /////////////
    
    func testDarkSideCharacters() {
        
        let fetchedCharactersExpectation = expectation(for: NSPredicate(format: "count > 0"), evaluatedWith: app.tables.cells, handler: nil)
        
        fetchedCharactersExpectation.expectationDescription = "Characters have been fetched and are displayed."
        
        app.buttons["fetchDarkSideButton"].tap()
        
        waitForExpectations(timeout: 5)
    }
    
    //MARK: Private
    
    private var restartButton: XCUIElement {
        return app.buttons["GameViewController.RestartButton"]
    }
    
    private var app: XCUIApplication {
        return XCUIApplication()
    }
    
    private var turnLabel: XCUIElement {
        return XCUIApplication().staticTexts["GameViewController.TurnLabel"]
    }
    
    private func button(forIndex index: Int) -> XCUIElement {
        return XCUIApplication().buttons["button\(index)"]
    }
}
