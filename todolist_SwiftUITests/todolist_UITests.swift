//
//  todolist_UITests.swift
//  todolist_SwiftUITests
//
//  Created by Stas Bezhan on 28.09.2022.
//

import XCTest
import ViewInspector
@testable import todolist_SwiftUI
import SwiftUI

extension MainView: Inspectable { }

final class todolist_UITests: XCTestCase {

    func test_pickerValues() throws {
        
        let sut = MainView()
        let picker = try sut.inspect().navigationView().form(0).section(0).picker(0)
        
        let value0 = try picker.forEach(0).text(0).string()
        let value1 = try picker.forEach(0).text(1).string()
        let value2 = try picker.forEach(0).text(2).string()
        
        XCTAssertEqual(value0, "Realm")
        XCTAssertEqual(value1, "Core Data")
        XCTAssertEqual(value2, "User Defaults")
    }
    
    func test_MainView_ListElements() throws {
        
        let sut = MainView()
        sut.viewModel.dataManager = MocDataManager()
        sut.viewModel.addNewObject()
        
        let list = try sut.inspect().navigationView().form(0).section(1).list(0)
        let vStack = try list.forEach(0).vStack(0)
        let vStackAllignment = try vStack.multilineTextAlignment()
        let objectTitle = try vStack.text(0)
        let objectTitleFont = try objectTitle.attributes().font()
        let objectDescription = try vStack.text(1)
        let objectDescriptionFont = try objectDescription.attributes().font()
        
        XCTAssertNotNil(list)
        XCTAssertNotNil(vStack)
        XCTAssertTrue(vStackAllignment == .leading)
        XCTAssertNotNil(objectTitle)
        XCTAssertTrue(objectTitleFont == .headline)
        XCTAssertNotNil(objectDescription)
        XCTAssertTrue(objectDescriptionFont == .body)
        
    }
    
    func test_MainView_Header() throws {
        
        let sut = MainView()
        let header = try sut.inspect().navigationView().form(0).section(1).header()
        
        let textObjectsOf = try header.hStack().text(0).string()
        let spacer = try header.hStack().spacer(1)
        let button = try header.hStack().button(2)
    
        XCTAssertTrue(textObjectsOf == "Objects of \n\(sut.viewModel.currentType.rawValue)")
        XCTAssertNotNil(spacer)
        XCTAssertNotNil(button)
        
    }
    
}
