//
//  w6d5_ui_performance_testingUITests.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by Alejandro Zielinsky on 2018-05-17.
//  Copyright © 2018 Roland. All rights reserved.
//

import XCTest

class w6d5_ui_performance_testingUITests: XCTestCase {
    
    
    var app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        super.tearDown()
        testDeleteAllMeals();
    }
    
    func addNewMeal(mealName : String, numberOfCalories : Int)
    {
        app.navigationBars["Master"].buttons["Add"].tap()
        
        let addAMealAlert = app.alerts["Add a Meal"]
        addAMealAlert.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
        
        
        for char in mealName
        {
            let key = app.keys[String(char)]
            key.tap()
        }
        
        let textField = addAMealAlert.collectionViews.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.tap()
        app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"more, numbers\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
   
        for char in String(numberOfCalories)
        {
            let key = app.keys[String(char)]
            key.tap()
        }
        
        addAMealAlert.buttons["Ok"].tap()
        
    }
    
    func deleteMeal(mealName : String, numberOfCalories : Int)
    {
        let staticText = app.tables.staticTexts["\(mealName) - \(numberOfCalories)"]
        if staticText.exists {
            staticText.swipeLeft()
            app.tables.buttons["Delete"].tap()
        }
    }
    
    func testDeleteMeal()
    {
        deleteMeal(mealName: "fries", numberOfCalories: 400)
    }
    
     func testAddMeal() {
        
        addNewMeal(mealName: "fries", numberOfCalories: 400)
    }
    
    func showMealDetail(mealName : String, numberOfCalories : Int)
    {
        app.tables.staticTexts["\(mealName) - \(numberOfCalories)"].tap()
        let label = app.staticTexts.element(matching: .any, identifier: "detailViewControllerLabel").label
        XCTAssertEqual(label, "\(mealName) - \(numberOfCalories)")
        app.navigationBars["Detail"].buttons["Master"].tap()
    }
    
    func deleteAllMeals()
    {
        for index in (0..<app.tables.cells.count).reversed() {
            let cell = app.tables.cells.element(boundBy: index)
            if cell.exists {
                cell.swipeLeft()
                app.tables.buttons["Delete"].tap()
            }
        }
    }
    
    public func testAddThenRemoveMeal()
    {
        addNewMeal(mealName: "burger", numberOfCalories: 300)
        deleteMeal(mealName: "burger", numberOfCalories: 300)
    }
    
    func testDeleteAllMeals()
    {
        deleteAllMeals()
    }
    
    
    func testShowMealDetail()
    {
        showMealDetail(mealName: "fries", numberOfCalories: 400)
    }
    
}
