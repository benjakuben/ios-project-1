//: Playground - noun: a place where people can play

import UIKit

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

// Keys for reuse
let keyName = "name"
let keyHeight = "height"
let keyPlayed = "playedBefore"
let keyGuardians = "guardians"

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

// **************************************
// Step 2: Spread out experienced players
// **************************************

var teamSharks: [[String: String]] = []
var teamDragons: [[String: String]] = []
var teamRaptors: [[String: String]] = []

func assign(player:[String: String], to:Int) {
    switch to {
        case 0:
            teamSharks.append(player)
        case 1:
            teamDragons.append(player)
        case 2:
            teamRaptors.append(player)
        default:
            print("Whoa, what happened? Error assigning teams.")
    }
}

// Counter for balancing experienced players
var experiencedCount = 0

for player in players {
    if player[keyPlayed] == "true" {
        let teamIndex = experiencedCount % 3 // Keep it to 3 teams
        assign(player: player, to:teamIndex)
        experiencedCount += 1
    }
}

// Make sure we start adding inexperienced players to the team with the smallest number of players
var teamIndexForSmallestTeam = 0

if teamSharks.count < teamDragons.count || teamSharks.count < teamRaptors.count {
    teamIndexForSmallestTeam = 0
}
else if teamDragons.count < teamSharks.count || teamDragons.count < teamRaptors.count {
    teamIndexForSmallestTeam = 1
}
else if teamRaptors.count < teamSharks.count || teamRaptors.count < teamDragons.count {
    teamIndexForSmallestTeam = 2
}

// Counter for balancing inexperienced players
var inexperiencedCount = teamIndexForSmallestTeam

for player in players {
    if player[keyPlayed] != "true" {
        let teamIndex = inexperiencedCount % 3 // Keep it to 3 teams
        assign(player: player, to:teamIndex)
        inexperiencedCount += 1
    }
}

// ********************************
// Step 3: Draft letters to players
// ********************************

func draftLetter(player:[String: String], team:String) -> String {
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
    
    switch team {
        case "Sharks":
            practiceTime = "6:00 PM"
            practiceDate = "9/1/2016"
        case "Dragons":
            practiceTime = "6:30 PM"
            practiceDate = "9/2/2016"
        case "Raptors":
            practiceTime = "2:00 PM"
            practiceDate = "9/3/2016"
        default:
            practiceTime = ""
            practiceDate = ""
    }
    
    let letterText = "To: \(guardians)\n\n" +
            "Welcome to the 2016 Treehouse Soccer League! \(name) has been assigned to the " +
            "\(team) team, and their first practice will be at \(practiceTime) on \(practiceDate). Thanks " +
            "for playing, and good luck this season!"
    
    return letterText
}

for player in teamSharks {
    let letter = draftLetter(player: player, team:"Sharks")
}

for player in teamDragons {
    let letter = draftLetter(player: player, team:"Dragons")
}

for player in teamRaptors {
    let letter = draftLetter(player: player, team:"Raptors")
}
































