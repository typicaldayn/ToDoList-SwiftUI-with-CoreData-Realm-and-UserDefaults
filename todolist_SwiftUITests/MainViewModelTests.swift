//
//  todolist_SwiftUITests.swift
//  todolist_SwiftUITests
//
//  Created by Stas Bezhan on 23.09.2022.
//
@testable import todolist_SwiftUI
import XCTest

final class MainViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_MainViewModel_dataManager_shouldNotBeNil() {
        let sut = MainViewModel()
        XCTAssertNotNil(sut.dataManager)
    }
    
    func test_MainViewModel_dataManager_shouldBeUserDefaults() {
        let sut = MainViewModel()
        sut.currentType = sut.savingTypes[2]
        XCTAssert(sut.dataManager is UserDefaultsManager)
    }
    
    func test_MainViewModel_dataManager_shouldBeCoreData() {
        let sut = MainViewModel()
        sut.currentType = sut.savingTypes[1]
        XCTAssert(sut.dataManager is CoreDataManager)
    }
    
    func test_MainViewModel_dataManager_shouldBeRealmManager() {
        let sut = MainViewModel()
        sut.currentType = sut.savingTypes[0]
        XCTAssert(sut.dataManager is RealmManager)
    }
    
    func test_MainView_dataManager_shouldSaveObjects() {
        let sut = MainViewModel()
        sut.dataManager = MocDataManager()
        sut.objects = []
        sut.addNewObject()
        XCTAssertTrue(!sut.objects.isEmpty)
        XCTAssertGreaterThan(sut.objects.count, 0)
    }
    
    func test_MainViewModel_deleteAt_shouldDelete() {
        let sut = MainViewModel()
        sut.dataManager = MocDataManager()
        let countOfObjects = sut.objects.count
        sut.addNewObject()
        sut.delete(at: IndexSet(integer: countOfObjects))
        XCTAssertTrue(sut.objects.count == 0)
    }
    
    func test_MainViewModel_alert_shouldBePresented() {
        let sut = MainViewModel()
        sut.alertPresenting.toggle()
        XCTAssertTrue(sut.alertPresenting)
    }
    
}
