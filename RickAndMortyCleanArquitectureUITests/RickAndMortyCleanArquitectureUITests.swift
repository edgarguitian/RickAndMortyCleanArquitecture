//
//  RickAndMortyCleanArquitectureUITests.swift
//  RickAndMortyCleanArquitectureUITests
//
//  Created by Edgar Guitian Rey on 22/12/23.
//

import XCTest

final class RickAndMortyCleanArquitectureUITests: XCTestCase {

    private var app: XCUIApplication!
    
    private let scrollCharactersIdentifier = "listCharacters"
    private let foreachCharactersIdentifier = "forEachCharacters"

    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDown()  {
        app = nil
    }

    func test_characters_list_scrolls() {
        print(app.debugDescription)
        let scrollCharacters = app.scrollViews[scrollCharactersIdentifier]
        let foreachCharacters = app.buttons[foreachCharactersIdentifier]
        XCTAssert(foreachCharacters.exists)
        while !scrollCharacters.isAtBottom {
            scrollCharacters.swipeUp()
        }
        
        
        let lastCharacter = app.staticTexts["Butter Robot"]
        XCTAssert(lastCharacter.exists)

    }
    
    func test_search() {
        let searchField = app.navigationBars["Characters"].searchFields["Search"]
        XCTAssertTrue(searchField.exists)

        searchField.tap()
        searchField.typeText("Rick")
        let characterRickSanchez = app.staticTexts["Rick Sanchez"]
        XCTAssert(characterRickSanchez.exists)
        let characterAdjudicatorRick = app.staticTexts["Adjudicator Rick"]
        XCTAssert(characterAdjudicatorRick.exists)
        let characterAlienRick = app.staticTexts["Alien Rick"]
        XCTAssert(characterAlienRick.exists)
        let characterAntennaRick = app.staticTexts["Antenna Rick"]
        XCTAssert(characterAntennaRick.exists)
        
    }
    
    func test_filter() {
                                
        
        app.navigationBars["Characters"]/*@START_MENU_TOKEN@*/.buttons["Edit"]/*[[".otherElements[\"Edit\"].buttons[\"Edit\"]",".buttons[\"Edit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Selecciona un status"]/*[[".cells",".buttons[\"Selecciona status, Selecciona un status\"].staticTexts[\"Selecciona un status\"]",".staticTexts[\"Selecciona un status\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let btnFilterUnknown = app.buttons["unknown"]
        XCTAssert(btnFilterUnknown.exists)
        print(app.debugDescription)
        btnFilterUnknown.tap()
        app.collectionViews.containing(.other, identifier:"Vertical scroll bar, 1 page").element.swipeDown()
        let characterAlienMorty = app.staticTexts["Alien Morty"]
        XCTAssert(characterAlienMorty.exists)
        let characterAlienRick = app.staticTexts["Alien Rick"]
        XCTAssert(characterAlienRick.exists)
                                        
    }
}

extension XCUIElement {
    var isAtBottom: Bool {
        // Comprueba si el contenido del ScrollView está en la parte inferior
        guard self.exists else { return false }
        return self.frame.contains(self.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.9)).screenPoint)
    }
}
