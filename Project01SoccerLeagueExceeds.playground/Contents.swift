/*
 Part 1: We have provided information for the 18 players in the Player Info spreadsheet. Please choose an appropriate data type to store the information for each player. In addition, create an empty collection variable to hold all the players’ data. Once you have decided on what tools to use, manually enter the player data so it can be used in Part 2.
 
 Part 2: Create logic that can iterate through all 18 players and assign them to teams such that the number of experienced players on each team are the same. Store each team’s players in its own new collection variable for use in Part 3. (Please note: your logic should work correctly regardless of the initial ordering of the players and should work, if we theoretically had more or less than 18 players, so NO MAGIC NUMBERS!)
 
 Also, if you would like to attain an “exceeds expectations” rating for this project, add logic to ensure that each teams’ average height is within 1.5 inches of the others.
 
 Part 3: Create logic that iterates through all three teams of players and generates a personalized letter to the guardians, letting them know which team their child has been placed on and when they should attend their first team team practice. As long as you provide the necessary information (player name, team name, guardians’ names, practice date/time), feel free to have fun with the content of the letter. The team practice dates/times are as follows: Dragons - March 17, 1pm, Sharks - March 17, 3pm, Raptors - March 18, 1pm
 
 When your complete code is run in a playground the letters should be visible in the right hand pane. If the code is run within an actual Xcode Project, the letters should be visible in the console.
 */

// name
// height (inches)
// played before
// guardian names

/*
 Manually create a single collection that contains all information for all 18 players. Each player should themselves be represented by their own collection.
 Create appropriate variables and logic to sort and store players into three teams: Sharks, Dragons and Raptors. Be sure that your logic results in all teams having the same number of experienced players on each.
 Provide logic that prints a personalized letter to the guardians specifying: the player’s name, guardians' names, team name, and date/time of their first team practice. The letters should be visible when code is placed in a XCode Playground or run in an XCode project.
 As always, please add concise and descriptive comments to your code and be sure to name your constants, variables and keys descriptively.
 Also, if you would like to attain an “exceeds expectations” rating for this project, add logic to ensure that each teams’ average height is within 1.5 inches of the others. (Please note, this feature only needs to meet the 1.5inch threshold for this set of players, not for all potential future sets of players.)
 */

/*
 To get an "exceeds" rating, add to this project:
 Logic to ensure that each team's average height is within 1.5 inch of the others as well as having each team contain the same number of experienced players. Your logic should be make use of dynamic values like the average height of teams or players and not be based on any magic numbers or hard-coded values. You should not rely on a particular ordering of the initial collection of players - the logic should work regardless of the order of players in the initial collection. (Please note, this feature only needs to meet the 1.5inch threshold for the set of players we provided, not for all potential future sets of players.) If you do not want to be considered for an “Exceeds Expectations” rating, you may skip this step.
 */

//import UIKit
import XCTest

// ***********************
// Variables and functions
// ***********************

let keyName = "name"
let keyHeight = "height"
let keyPlayed = "playedBefore"
let keyGuardians = "guardians"

var teamSharks: [[String: String]] = []
var teamDragons: [[String: String]] = []
var teamRaptors: [[String: String]] = []

let sharksName = "Sharks"
let dragonsName = "Dragons"
let raptorsName = "Raptors"

let sharksIndex = 0
let dragonsIndex = 1
let raptorsIndex = 2

let numberOfTeams = 3

var experiencedPlayers: [[String: String]] = []
var inexperiencedPlayers: [[String: String]] = []

// Assign a specific player (dict) to a specific team, based on the team index
func assign(player:[String: String], to:Int) {
    switch to {
    case sharksIndex:
        teamSharks.append(player)
    case dragonsIndex:
        teamDragons.append(player)
    case raptorsIndex:
        teamRaptors.append(player)
    default:
        print("Whoa, what happened? Error assigning teams.")
    }
}

// Get the tallest player from an array of players
func getTallestPlayer(players: [[String: String]]) -> (index: Int, player: [String: String]) {
    var tallestPlayer: [String: String] = [String: String]()
    var maxHeight = 0.0
    
    var index = 0
    var i = 0
    for player in players {
        if player[keyHeight] != nil {
            let playerHeight: Double? = Double(player[keyHeight]!)
            if playerHeight != nil && playerHeight > maxHeight {
                maxHeight = playerHeight!
                tallestPlayer = player
                index = i
            }
        }
        i += 1
    }
    
    return (index, tallestPlayer)
}

// Get the shortest player from an array of players
func getShortestPlayer(players: [[String: String]]) -> (index: Int, player: [String: String]) {
    var shortestPlayer: [String: String] = [String: String]()
    var minHeight = 9999.0
    
    var index = 0
    var i = 0
    for player in players {
        if player[keyHeight] != nil {
            let playerHeight: Double? = Double(player[keyHeight]!)
            if playerHeight != nil && playerHeight < minHeight {
                minHeight = playerHeight!
                shortestPlayer = player
                index = i
            }
        }
        i += 1
    }
    
    return (index, shortestPlayer)
}

// Calculate the average height of a given team
func getTeamAverageHeight(team:[[String: String]]) -> Double {
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

// Calculate the average heights of each team, rank them, and return a specific one
// based on a provided index
func getTeamHeightRank(teamIndex: Int) -> Int {
    let sharksAvgHeight = getTeamAverageHeight(teamSharks)
    let dragonsAvgHeight = getTeamAverageHeight(teamDragons)
    let raptorsAvgHeight = getTeamAverageHeight(teamRaptors)
    
    // Lowest rank by default
    var sharksRank = 3
    var dragonsRank = 3
    var raptorsRank = 3
    
    // Set Sharks rank
    if sharksAvgHeight > dragonsAvgHeight && sharksAvgHeight > raptorsAvgHeight {
        sharksRank = 1
    }
    else if sharksAvgHeight < dragonsAvgHeight && sharksAvgHeight > raptorsAvgHeight {
        sharksRank = 2
    }
    else if sharksAvgHeight < raptorsAvgHeight && sharksAvgHeight > dragonsAvgHeight {            sharksRank = 2
    }
    
    // Set Dragons rank
    if dragonsAvgHeight > sharksAvgHeight && dragonsAvgHeight > raptorsAvgHeight {
        dragonsRank = 1
    }
    else if dragonsAvgHeight < sharksAvgHeight && dragonsAvgHeight > raptorsAvgHeight {
        dragonsRank = 2
    }
    else if dragonsAvgHeight < raptorsAvgHeight && dragonsAvgHeight > sharksAvgHeight {
        dragonsRank = 2
    }
    
    // Set Raptors rank
    if raptorsAvgHeight > sharksAvgHeight && raptorsAvgHeight > dragonsAvgHeight {
        raptorsRank = 1
    }
    else if raptorsAvgHeight < sharksAvgHeight && raptorsAvgHeight > dragonsAvgHeight {
        raptorsRank = 2
    }
    else if raptorsAvgHeight < dragonsAvgHeight && raptorsAvgHeight > sharksAvgHeight {
        raptorsRank = 2
    }
    
    if teamIndex == sharksIndex {
        return sharksRank
    }
    else if teamIndex == dragonsIndex {
        return dragonsRank
    }
    else {
        return raptorsRank
    }
}

// Draft a letter to a specific player on a given team name
func draftLetter(player:[String: String], teamName:String) -> String {
    var name = "Player"
    if player[keyName] != nil {
        name = player[keyName]!
    }
    
    var guardians = "Guardians"
    if player[keyGuardians] != nil {
        guardians = player[keyGuardians]!
    }
    
    var practiceTime: String
    var practiceDate: String
    
    switch teamName {
    case sharksName:
        practiceTime = "6:00 PM"
        practiceDate = "9/1/2016"
    case dragonsName:
        practiceTime = "6:30 PM"
        practiceDate = "9/2/2016"
    case raptorsName:
        practiceTime = "2:00 PM"
        practiceDate = "9/3/2016"
    default:
        practiceTime = ""
        practiceDate = ""
    }
    
    let letterText = "To: \(guardians)\n\n" +
        "Welcome to the 2016 Treehouse Soccer League! \(name) has been assigned to the " +
        "\(teamName) team, and their first practice will be at \(practiceTime) on \(practiceDate). Thanks " +
    "for playing, and good luck this season!"
    
    return letterText
}

// **************************
// Step 1: Player data store!
// **************************

let players = [
    [keyName:"Joe Smith", keyHeight:"42", keyPlayed:"true", keyGuardians:"Jim and Jan Smith"],
    [keyName:"Jill Tanner", keyHeight:"36", keyPlayed:"true", keyGuardians:"Clara Tanner"],
    [keyName:"Bill Bon", keyHeight:"43", keyPlayed:"true", keyGuardians:"Sara and Jenny Bon"],
    [keyName:"Eva Gordon", keyHeight:"45", keyPlayed:"false", keyGuardians:"Wendy and Mike Gordon"],
    [keyName:"Matt Gill", keyHeight:"40", keyPlayed:"false", keyGuardians:"Charles and Sylvia Gill"],
    [keyName:"Kimmy Stein", keyHeight:"41", keyPlayed:"false", keyGuardians:"Bill and Hillary Stein"],
    [keyName:"Sammy Adams", keyHeight:"45", keyPlayed:"false", keyGuardians:"Jeff Adams"],
    [keyName:"Karl Saygan", keyHeight:"42", keyPlayed:"true", keyGuardians:"Heather Bledsoe"],
    [keyName:"Suzane Greenberg", keyHeight:"44", keyPlayed:"true", keyGuardians:"Henrietta Dumas"],
    [keyName:"Sal Dali", keyHeight:"41", keyPlayed:"false", keyGuardians:"Gala Dali"],
    [keyName:"Joe Kavalier", keyHeight:"39", keyPlayed:"false", keyGuardians:"Sam and Elaine Kavalier"],
    [keyName:"Ben Finkelstein", keyHeight:"44", keyPlayed:"false", keyGuardians:"Aaron and Jill Finkelstein"],
    [keyName:"Diego Soto", keyHeight:"41", keyPlayed:"true", keyGuardians:"Robin and Sarika Soto"],
    [keyName:"Chloe Alaska", keyHeight:"47", keyPlayed:"false", keyGuardians:"David and Jamie Alaska"],
    [keyName:"Arnold Willis", keyHeight:"43", keyPlayed:"false", keyGuardians:"Claire Willis"],
    [keyName:"Phillip Helm", keyHeight:"44", keyPlayed:"true", keyGuardians:"Thomas Helm and Eva Jones"],
    [keyName:"Les Clay", keyHeight:"42", keyPlayed:"true", keyGuardians:"Wynonna Brown"],
    [keyName:"Herschel Krustofski", keyHeight:"45", keyPlayed:"true", keyGuardians:"Hyman and Rachel Krustofski"]
]

// ****************************************************
// Step 2: Assign teams (with equalized average height)
// ****************************************************

// Sort the players by experience into two arrays
for player in players {
    if player[keyPlayed] == "true" {
        experiencedPlayers.append(player)
    }
    else {
        inexperiencedPlayers.append(player)
    }
}

// Step 2a. Assign experienced players
// ***********************************
var assignedCount = 0
var playerType = ""

while experiencedPlayers.count > 0 {
    // Flip from tallest to shortest each pass through the teams
    if assignedCount % numberOfTeams == 0 {
        if playerType == "tallest" {
            playerType = "shortest"
        }
        else {
            playerType = "tallest"
        }
    }

    // Get the tallest (or shortest) player left
    var index: Int
    var player: [String: String]
    if playerType == "tallest" {
        (index, player) = getTallestPlayer(experiencedPlayers)
    }
    else {
        (index, player) = getShortestPlayer(experiencedPlayers)
    }
    
    // Assign the player (keep it to n teams)
    var teamIndex = assignedCount % numberOfTeams
    assign(player, to:teamIndex)
    assignedCount += 1
    
    // Remove them from the array
    experiencedPlayers.removeAtIndex(index)
}

// Step 2b. Assign inexperienced players
// *************************************

// Make sure we start adding inexperienced players to the team with the smallest number of players
var assignIndex = 0

if teamSharks.count < teamDragons.count || teamSharks.count < teamRaptors.count {
    assignIndex = 0
}
else if teamDragons.count < teamSharks.count || teamDragons.count < teamRaptors.count {
    assignIndex = 1
}
else if teamRaptors.count < teamSharks.count || teamRaptors.count < teamDragons.count {
    assignIndex = 2
}

while inexperiencedPlayers.count > 0 {
    let heightRank = getTeamHeightRank(assignIndex)
    
    var index: Int
    var player: [String: String]
    if heightRank == 3 {
        // Get the tallest player
        (index, player) = getTallestPlayer(inexperiencedPlayers)
    }
    else {
        // Get the shortest player
        (index, player) = getShortestPlayer(inexperiencedPlayers)
    }
    
    // Assign the player (keep it to n teams)
    var teamIndex = assignIndex % numberOfTeams
    assign(player, to:teamIndex)
    assignIndex += 1
    
    // Remove them from the array
    inexperiencedPlayers.removeAtIndex(index)
}

// ********************************
// Step 3: Draft letters to players
// ********************************

for player in teamSharks {
    let letter = draftLetter(player, teamName:sharksName)
}

for player in teamDragons {
    let letter = draftLetter(player, teamName:dragonsName)
}

for player in teamRaptors {
    let letter = draftLetter(player, teamName:raptorsName)
}


// ****************************************************************
// ****************************************************************
// ****************************************************************
//                           UNIT TESTS!!!!!!
// ****************************************************************
// ****************************************************************
// ****************************************************************

// Helper functions for unit testing
struct THTestHelper {
    static let sharksName = "Sharks"
    static let dragonsName = "Dragons"
    static let raptorsName = "Raptors"
    
    static let keyName = "name"
    static let keyHeight = "height"
    static let keyPlayed = "playedBefore"
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
    
    static func isVarAnArrayOfDict(varToCheck: Any) -> Bool {
        return varToCheck is [[String: String]]
    }
}

// All the test cases
class THProjectOneMeetsTests: XCTestCase {
    
    func testPlayersIsArrayOfDict() {
        XCTAssert(THTestHelper.isVarAnArrayOfDict(players), "players is not an array of [String: String]")
    }
    
    func testTeamSharksIsArrayOfDict() {
        XCTAssert(THTestHelper.isVarAnArrayOfDict(teamSharks), "teamSharks is not an array of [String: String]")
    }
    
    func testTeamDragonsIsArrayOfDict() {
        XCTAssert(THTestHelper.isVarAnArrayOfDict(teamDragons), "teamDragons is not an array of [String: String]")
    }
    
    func testTeamRaptorsIsArrayOfDict() {
        XCTAssert(THTestHelper.isVarAnArrayOfDict(teamRaptors), "teamRaptors is not an array of [String: String]")
    }
    
    func testNumberOfPlayersInArrayIs18() {
        XCTAssertEqual(players.count, 18)
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
            if player[THTestHelper.keyPlayed] == "true" {
                sharksExperiencedCount += 1
            }
        }
        
        for player in teamSharks {
            if player[THTestHelper.keyPlayed] == "true" {
                dragonsExperiencedCount += 1
            }
        }
        
        for player in teamSharks {
            if player[THTestHelper.keyPlayed] == "true" {
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


/*
 NOTES FOR UNIT TESTING
 - Playground needs to be OS X platform, not iOS
 - We'll need to strip out import UIKit
 - We'll need to append the tests directy to the file
 - Store players in an array named 'players'
 - Store teams as dictionaries, String: String, named teamSharks, teamDragons, and teamRaptors
 - Specify keys as:
     "name"
     "height"
     "playedBefore"
     "guardians"
 
 
 http://initwithstyle.net/2015/11/tdd-in-swift-playgrounds/
 */