//
//  NASA_APODUITests.swift
//  NASA APODUITests
//
//  Created by longarinas on 01/02/25.
//

import XCTest
@testable import NASA_APOD

final class NASA_APODUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app.terminate()
        super.tearDown()
    }
    
    func testTabBarItems() {
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssert(tabBar.buttons["Astros"].exists)
        XCTAssert(tabBar.buttons["Favorites"].exists)
    }
    
    func testFavorite_and_back_to_initial_state() {
        let favoriteButton = app.buttons["favorite_button"]
        favoriteButton.tap()
        
        let astroName = app.staticTexts["astro_name"].label
        
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Favorites"].tap()
        
        let astroNameFromFavorite = app.staticTexts["fav_astro_name"].label
        
        XCTAssertEqual(astroName, astroNameFromFavorite)
        
        tabBar.buttons["Astros"].tap()
        favoriteButton.tap()
    }
    
    func testFavorite_expand_item_and_back_to_initial_state() {
        let favoriteButton = app.buttons["favorite_button"]
        favoriteButton.tap()

        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Favorites"].tap()
     
        let titleSectionButton = app.buttons["title_section_button"]
        titleSectionButton.tap()
        let seeMore = app.buttons["see_more"]
        
        XCTAssertTrue(seeMore.exists)
        
        tabBar.buttons["Astros"].tap()
        favoriteButton.tap()
    }
    
    func testNonFavorite_and_back_to_initial_state() {
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Favorites"].tap()
        let astroNameFromFavorite = app.staticTexts["fav_astro_name"]
        XCTAssertFalse(astroNameFromFavorite.exists)
    }
}
