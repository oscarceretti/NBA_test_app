//
//  NBA_TeamsTests.swift
//  NBA TeamsTests
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import XCTest
@testable import NBA_Teams

class NBA_TeamsTests: XCTestCase {

    var sut: NBAManager? = NBAManager()
    
    override func setUpWithError() throws {
        sut = nil
    }
    
    func test_getTeamsList_ShuldBenotNil() {
        var getTeamsOutput: Teams?
        var err: Error?
        sut = NBAManager()
        
        let expectation = XCTestExpectation(description: "Expect to get not nil")
        //When
        sut?.getTeamList() {
            debugPrint("start")
        } completion: { (result) in
            switch result {
            
            case .success(let data):
                getTeamsOutput = data
                expectation.fulfill()
            case .failure(let error):
                err = error
            }
        } onComplete: {
            
        }
        
        wait(for: [expectation], timeout: 5.0)

        //Then
        XCTAssertNotNil(getTeamsOutput)
    }
    
    func test_getTeamsList_ShuldBeNil() {
        var getTeamsOutput: Teams?
        var err: Error?
        sut = NBAManager()
        
        let expectation = XCTestExpectation(description: "Expect to get not nil")
        //When
        sut?.getTeamList() {
            debugPrint("start")
        } completion: { (result) in
            switch result {
            
            case .success(let data):
                getTeamsOutput = data
                expectation.fulfill()
            case .failure(let error):
                err = error
            }
        } onComplete: {
            
        }
        
        wait(for: [expectation], timeout: 5.0)

        //Then
        XCTAssertNotNil(getTeamsOutput)
    }
    
    
    func test_getPlayerList_ShuldBeNotNil() {
        var getPlayerOutput: PlayersContainer?
        var err: Error?
        sut = NBAManager()
        
        let expectation = XCTestExpectation(description: "Expect to get not nil")
        //When
        sut?.getPLayerList(page: 1) {
            debugPrint("start")
        } completion: { (result) in
            switch result {
            
            case .success(let data):
                getPlayerOutput = data
                expectation.fulfill()
            case .failure(let error):
                err = error
            }
        } onComplete: {
            
        }
        
        wait(for: [expectation], timeout: 5.0)

        //Then
        XCTAssertNotNil(getPlayerOutput)
    }
    
    func test_getSinglePlayer_ShuldBeNotNil() {
        var getPlayerOutput: Player?
        var err: Error?
       
        sut = NBAManager()
        
        let expectation = XCTestExpectation(description: "Expect to get not nil")
        //When
        sut?.getPlayer(id: 1) {
            debugPrint("start")
        } completion: { (result) in
            switch result {
            case .success(let data):
                getPlayerOutput = data
                expectation.fulfill()
            case .failure(let error):
                err = error
            }
        } onComplete: {
            
        }
        
        wait(for: [expectation], timeout: 5.0)
        //Then
        XCTAssertNotNil(getPlayerOutput)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func createSut() -> NBAManager {
        return NBAManager()
    }

}

