// ****************************************************************
// ****************************************************************
// ****************************************************************
//                           UNIT TESTS!!!!!!
// ****************************************************************
// ****************************************************************
// ****************************************************************

// Helper functions for unit testing
struct THTestHelper {
    static let expectedNumberOfPlayers = 18
    static let expectedTeamSize = 6
    
    static let sharksName = "Sharks"
    static let dragonsName = "Dragons"
    static let raptorsName = "Raptors"
    
    static let sharksPracticeDate = "Sep 1"
    static let sharksPracticeTime = "5:30 PM"
    static let dragonsPracticeDate = "Sep 2"
    static let dragonsPracticeTime = "6:30 PM"
    static let raptorsPracticeDate = "Sep 3"
    static let raptorsPracticeTime = "7:30 PM"
    
    static let keyName = "name"
    static let keyHeight = "height"
    static let keyExperience = "experience"
    static let keyGuardians = "guardians"
    
    // Calculate the average height of a given team
    static func getAverageHeightForTeam(team:[[String: String]]) -> Double {
        if team.count == 0 {
            return 0
        }
        
        var totalHeight: Double = 0
        for player in team {
            if player[keyHeight] != nil {
                let playerHeight: Double? = Double(player[keyHeight]!)
                if playerHeight != nil {
                    totalHeight += playerHeight!
                }
            }
        }
        
        return totalHeight / Double(team.count)
    }
    
    // Check if a given variable is an array of dictionaries with [String: String] key/value pairs
    static func isVarAnArrayOfDict(varToCheck: Any) -> Bool {
        return varToCheck is [[String: String]]
    }
    
    // Check to make sure keys are used in a dictionary (and return values)
    static func testForInvalidKey(keyToTest: String) -> Bool {
        for player in players {
            if player[keyToTest] == nil {
                return true
            }
        }
        
        return false
    }
}

/////////////////////////////////////////
// Test cases for "Meets" expectations
//
class THProjectOneMeetsTests: XCTestCase {
    
    func testPlayersIsArrayOfDict() {
        XCTAssert(THTestHelper.isVarAnArrayOfDict(players), "'players' is not an array of [String: String]")
    }
    
    func testPlayersDictionaryHasCorrectKeys() {
        XCTAssertFalse(THTestHelper.testForInvalidKey(THTestHelper.keyName), "You are using the wrong key for player name (or have corrupt data).)")

        XCTAssertFalse(THTestHelper.testForInvalidKey(THTestHelper.keyHeight), "You are using the wrong key for height (or have corrupt data).")

        XCTAssertFalse(THTestHelper.testForInvalidKey(THTestHelper.keyExperience), "You are using the wrong key for experience (or have corrupt data).")

        XCTAssertFalse(THTestHelper.testForInvalidKey(THTestHelper.keyGuardians), "You are using the wrong key for guardian names (or have corrupt data).")
    }
    
    func testTeamsAreArraysOfDictionaries() {
        XCTAssert(THTestHelper.isVarAnArrayOfDict(teamSharks), "'teamSharks' is not an array of [String: String]")
        XCTAssert(THTestHelper.isVarAnArrayOfDict(teamDragons), "'teamDragons' is not an array of [String: String]")
        XCTAssert(THTestHelper.isVarAnArrayOfDict(teamRaptors), "'teamRaptors' is not an array of [String: String]")
    }
    
    func testTeamsAreCorrectSizes() {
        XCTAssertEqual(teamSharks.count, THTestHelper.expectedTeamSize, "The \(THTestHelper.sharksName) team size (\(teamSharks.count)) does not equal the expected size (\(THTestHelper.expectedTeamSize))")

        XCTAssertEqual(teamDragons.count, THTestHelper.expectedTeamSize, "The \(THTestHelper.dragonsName) team size (\(teamDragons.count)) does not equal the expected size (\(THTestHelper.expectedTeamSize))")
 
        XCTAssertEqual(teamRaptors.count, THTestHelper.expectedTeamSize, "The \(THTestHelper.raptorsName) team size (\(teamRaptors.count)) does not equal the expected size (\(THTestHelper.expectedTeamSize))")
    }
    
    func testNumberOfPlayersInArrayIsCorrect() {
        XCTAssertEqual(players.count, THTestHelper.expectedNumberOfPlayers)
    }
    
    func testTeamsHaveSameNumberOfPlayers() {
        let errorMsg = "Error! Teams are uneven:\n" +
            "\(THTestHelper.sharksName): \(teamSharks.count) players\n" +
            "\(THTestHelper.dragonsName): \(teamDragons.count) players\n" +
            "\(THTestHelper.raptorsName): \(teamRaptors.count) players"
        XCTAssert(teamSharks.count == teamDragons.count && teamSharks.count == teamRaptors.count, errorMsg)
    }
    
    func testEachTeamHasSameNumberOfExperiencedPlayers() {
        var sharksExperiencedCount = 0
        var dragonsExperiencedCount = 0
        var raptorsExperiencedCount = 0
        
        for player in teamSharks {
            if player[THTestHelper.keyExperience] == "YES" {
                sharksExperiencedCount += 1
            }
        }
        
        for player in teamSharks {
            if player[THTestHelper.keyExperience] == "YES" {
                dragonsExperiencedCount += 1
            }
        }
        
        for player in teamSharks {
            if player[THTestHelper.keyExperience] == "YES" {
                raptorsExperiencedCount += 1
            }
        }
        
        let errorMsg = "Error! Experienced players are uneven (should be 3 on each team):\n" +
            "\(THTestHelper.sharksName): \(sharksExperiencedCount) experienced players\n" +
            "\(THTestHelper.dragonsName): \(dragonsExperiencedCount) experienced players\n" +
            "\(THTestHelper.raptorsName): \(raptorsExperiencedCount) experienced players"
        
        let expectedExperiencedCount = 3
        XCTAssert(sharksExperiencedCount == expectedExperiencedCount &&
            dragonsExperiencedCount == expectedExperiencedCount &&
            raptorsExperiencedCount == expectedExperiencedCount,
            errorMsg)
    }
    
    func testLettersIsArrayOfStrings() {
        XCTAssert(letters as Any is [String], "'letters' is not an array of [String]")
    }
    
    func testNumberOfLettersInArrayIsCorrect() {
        XCTAssertEqual(letters.count, THTestHelper.expectedNumberOfPlayers)
    }
    
    func testContentsOfLettersFor(teamName: String) {
        var playerFound = false
        var teamLetterCount = 0
        
        var team: [[String: String]] = []
        var teamPracticeDate = ""
        var teamPracticeTime = ""
        
        switch(teamName) {
        case THTestHelper.sharksName:
            team = teamSharks
            teamPracticeDate = THTestHelper.sharksPracticeDate
            teamPracticeTime = THTestHelper.sharksPracticeTime
        case THTestHelper.dragonsName:
            team = teamDragons
            teamPracticeDate = THTestHelper.dragonsPracticeDate
            teamPracticeTime = THTestHelper.dragonsPracticeTime
        case THTestHelper.raptorsName:
            team = teamRaptors
            teamPracticeDate = THTestHelper.raptorsPracticeDate
            teamPracticeTime = THTestHelper.raptorsPracticeTime
        default:
            team = []
        }
        
        for player in team {
            playerFound = false // reset the playerFound flag each time
            let playerName = player[THTestHelper.keyName]!
            
            for letter in letters {
                // Find the matching letter based on the player's name
                if letter.containsString(playerName) {
                    // Flag the player letter found
                    playerFound = true
                    teamLetterCount += 1
                    
                    let errorMsgGuardian = "Could not find guardians '\(player[THTestHelper.keyGuardians]!)' in the letter for \(playerName)"
                    let errorMsgTeamName = "Could not find team name '\(teamName)' in the letter for \(playerName)"
                    let errorMsgPracticeDate = "Could not find practice date '\(teamPracticeDate)' in the letter for \(playerName)"
                    let errorMsgPracticeTime = "Could not find practice time '\(teamPracticeTime)' in the letter for \(playerName)"
                    
                    XCTAssert(letter.containsString(player[THTestHelper.keyGuardians]!), errorMsgGuardian)
                    XCTAssert(letter.containsString(teamName), errorMsgTeamName)
                    XCTAssert(letter.containsString(teamPracticeDate), errorMsgPracticeDate)
                    XCTAssert(letter.containsString(teamPracticeTime), errorMsgPracticeTime)
                }
            }
         
            // Make sure a letter was found for this player
            XCTAssert(playerFound, "Could not find a letter for the player named '\(playerName)'.")
        }
        
        XCTAssertEqual(teamLetterCount, THTestHelper.expectedTeamSize)
    }
    
    func testLetters() {
        testContentsOfLettersFor(THTestHelper.sharksName)
        testContentsOfLettersFor(THTestHelper.dragonsName)
        testContentsOfLettersFor(THTestHelper.raptorsName)
    }
}

///////////////////////////////////////////
// Test cases for "Exceeds" expectations
//
class THProjectOneExceedsTests: XCTestCase {

    func testAverageTeamHeightsAreClose() {
        let sharksHeight = THTestHelper.getAverageHeightForTeam(teamSharks)
        let dragonsHeight = THTestHelper.getAverageHeightForTeam(teamDragons)
        let raptorsHeight = THTestHelper.getAverageHeightForTeam(teamRaptors)
        
        let allowedHeightDiff = 1.5
        let errorMsg = "Error! Team heights are more than \(allowedHeightDiff) inches apart!\n" +
            "\(THTestHelper.sharksName): \(sharksHeight)\n" +
            "\(THTestHelper.dragonsName): \(dragonsHeight)\n" +
            "\(THTestHelper.raptorsName): \(raptorsHeight)"
        
        XCTAssert((abs(sharksHeight - dragonsHeight) <= allowedHeightDiff &&
            abs(sharksHeight - raptorsHeight) <= allowedHeightDiff &&
            abs(dragonsHeight - raptorsHeight) <= allowedHeightDiff),
                  errorMsg)
    }
}

/////////////////
// TEST RUNNER
//
class PlaygroundTestObserver : NSObject, XCTestObservation {
    @objc func testCase(testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt) {
        print("Test failed on line \(lineNumber): \(testCase.name), \(description)")
    }
}

let observer = PlaygroundTestObserver()
let center = XCTestObservationCenter.sharedTestObservationCenter()
center.addTestObserver(observer)

struct TestRunner {
    
    func runTests(testClass:AnyClass) {
        print("Running test suite \(testClass)")
        
        let tests = testClass as! XCTestCase.Type
        let testSuite = tests.defaultTestSuite()
        testSuite.runTest()
        let run = testSuite.testRun as! XCTestSuiteRun
        
        print("Ran \(run.executionCount) tests in \(run.testDuration)s with \(run.totalFailureCount) failures")
    }
}

TestRunner().runTests(THProjectOneMeetsTests)
TestRunner().runTests(THProjectOneExceedsTests)


/*
 NOTES FOR UNIT TESTING
 - Playground needs to be OS X platform, not iOS
 - We'll need to prepend import XCTest
 - We'll need to append the tests directy to the file
 - Store players in an array named 'players'
 - Store teams as dictionaries, String: String, named teamSharks, teamDragons, and teamRaptors
 - Specify keys as:
     - "name"
     - "height"
     - "experience" - use YES/NO as values
     - "guardians"
 - Store letters in an array named 'letters'
 - This project does not test other player sets, but reviewers could copy/paste an alternate set in to give advice for improvements
 - Specify date and time for practice (no year)
 
 http://initwithstyle.net/2015/11/tdd-in-swift-playgrounds/
 */
