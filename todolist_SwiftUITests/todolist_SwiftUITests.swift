//
//  todolist_SwiftUITests.swift
//  todolist_SwiftUITests
//
//  Created by Stas Bezhan on 23.09.2022.
//
@testable import todolist_SwiftUI
import XCTest

final class todolist_SwiftUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_MainViewModel_dataManager_shouldBeUserDefaults() {
        //Given
        let viewModel = MainViewModel()
        //When
        viewModel.currentType = viewModel.savingTypes[2]
        //Then
        XCTAssert(viewModel.dataManager is UserDefaultsManager)
    }

    func test_MainViewModel_dataManager_shouldBeCoreData() {
        //Given
        let viewModel = MainViewModel()
        //When
        viewModel.currentType = viewModel.savingTypes[1]
        //Then
        XCTAssert(viewModel.dataManager is CoreDataManager)
    }
    
    func test_MainViewModel_dataManager_shouldBeRealmManager() {
        //Given
        let viewModel = MainViewModel()
        //When
        viewModel.currentType = viewModel.savingTypes[0]
        //Then
        XCTAssert(viewModel.dataManager is RealmManager)
    }
    
    func test_MainView_dataManager_shouldSaveObjects() {
        //Given
        let viewModel = MainViewModel()
        //When
        viewModel.objects = []
        viewModel.addNewObject()
        //Then
        XCTAssertTrue(!viewModel.objects.isEmpty)
        XCTAssertGreaterThan(viewModel.objects.count, 0)
    }
    
    func test_MainViewModel_deleteAt_shouldDelete() {
        let viewModel = MainViewModel()
        
        let count = viewModel.objects.count
        viewModel.addNewObject()
        viewModel.delete(at: IndexSet(integer: viewModel.objects.count - 1))
        
        XCTAssertTrue(viewModel.objects.count == count)
        
    }
    
}
