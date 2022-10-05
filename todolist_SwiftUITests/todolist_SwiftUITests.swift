//
//  todolist_SwiftUITests.swift
//  todolist_SwiftUITests
//
//  Created by Stas Bezhan on 23.09.2022.
//
@testable import todolist_SwiftUI
import XCTest

//SUT

final class todolist_SwiftUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_MainViewModel_dataManager_shouldNotBeNil() {
        let sut = MainViewModel()
        XCTAssertNotNil(sut.dataManager)
    }
    
    func test_MainViewModel_dataManager_shouldBeUserDefaults() {
        //Given
        let sut = MainViewModel()
        //When
        sut.currentType = sut.savingTypes[2]
        //Then
        XCTAssert(sut.dataManager is UserDefaultsManager)
    }
    
    func test_MainViewModel_dataManager_shouldBeCoreData() {
        //Given
        let sut = MainViewModel()
        //When
        sut.currentType = sut.savingTypes[1]
        //Then
        XCTAssert(sut.dataManager is CoreDataManager)
    }
    
    func test_MainViewModel_dataManager_shouldBeRealmManager() {
        //Given
        let sut = MainViewModel()
        //When
        sut.currentType = sut.savingTypes[0]
        //Then
        XCTAssert(sut.dataManager is RealmManager)
    }
    
    func test_MainView_dataManager_shouldSaveObjects() {
        //Given
        let sut = MainViewModel()
        sut.dataManager = MocDataManager()
        sut.objects = []
        //When
        sut.addNewObject()
        //Then
        XCTAssertTrue(!sut.objects.isEmpty)
        XCTAssertGreaterThan(sut.objects.count, 0)
    }
    
    func test_MainViewModel_deleteAt_shouldDelete() {
        //Given
        let sut = MainViewModel()
        sut.dataManager = MocDataManager()
        let countOfObjects = sut.objects.count
        //When
        sut.addNewObject()
        sut.delete(at: IndexSet(integer: countOfObjects))
        //Then
        XCTAssertTrue(sut.objects.count == 0)
    }
    
    func test_MainViewModel_alert_shouldBePresented() {
        //Given
        let sut = MainViewModel()
        //When
        sut.alertPresenting.toggle()
        //Then
        XCTAssertTrue(sut.alertPresenting)
    }
    
}
