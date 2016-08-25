// ***********************
// Variables and functions
// ***********************

let keyName = "name"
let keyHeight = "height"
let keyExperience = "experience"
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
    else if sharksAvgHeight < raptorsAvgHeight && sharksAvgHeight > dragonsAvgHeight {
        sharksRank = 2
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
        practiceTime = "5:30 PM"
        practiceDate = "Sep 1"
    case dragonsName:
        practiceTime = "6:30 PM"
        practiceDate = "Sep 2"
    case raptorsName:
        practiceTime = "7:30 PM"
        practiceDate = "Sep 3"
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
    [keyName:"Joe Smith", keyHeight:"42", keyExperience:"YES", keyGuardians:"Jim and Jan Smith"],
    [keyName:"Jill Tanner", keyHeight:"36", keyExperience:"YES", keyGuardians:"Clara Tanner"],
    [keyName:"Bill Bon", keyHeight:"43", keyExperience:"YES", keyGuardians:"Sara and Jenny Bon"],
    [keyName:"Eva Gordon", keyHeight:"45", keyExperience:"NO", keyGuardians:"Wendy and Mike Gordon"],
    [keyName:"Matt Gill", keyHeight:"40", keyExperience:"NO", keyGuardians:"Charles and Sylvia Gill"],
    [keyName:"Kimmy Stein", keyHeight:"41", keyExperience:"NO", keyGuardians:"Bill and Hillary Stein"],
    [keyName:"Sammy Adams", keyHeight:"45", keyExperience:"NO", keyGuardians:"Jeff Adams"],
    [keyName:"Karl Saygan", keyHeight:"42", keyExperience:"YES", keyGuardians:"Heather Bledsoe"],
    [keyName:"Suzane Greenberg", keyHeight:"44", keyExperience:"YES", keyGuardians:"Henrietta Dumas"],
    [keyName:"Sal Dali", keyHeight:"41", keyExperience:"NO", keyGuardians:"Gala Dali"],
    [keyName:"Joe Kavalier", keyHeight:"39", keyExperience:"NO", keyGuardians:"Sam and Elaine Kavalier"],
    [keyName:"Ben Finkelstein", keyHeight:"44", keyExperience:"NO", keyGuardians:"Aaron and Jill Finkelstein"],
    [keyName:"Diego Soto", keyHeight:"41", keyExperience:"YES", keyGuardians:"Robin and Sarika Soto"],
    [keyName:"Chloe Alaska", keyHeight:"47", keyExperience:"NO", keyGuardians:"David and Jamie Alaska"],
    [keyName:"Arnold Willis", keyHeight:"43", keyExperience:"NO", keyGuardians:"Claire Willis"],
    [keyName:"Phillip Helm", keyHeight:"44", keyExperience:"YES", keyGuardians:"Thomas Helm and Eva Jones"],
    [keyName:"Les Clay", keyHeight:"42", keyExperience:"YES", keyGuardians:"Wynonna Brown"],
    [keyName:"Herschel Krustofski", keyHeight:"45", keyExperience:"YES", keyGuardians:"Hyman and Rachel Krustofski"]
]

// ****************************************************
// Step 2: Assign teams (with equalized average height)
// ****************************************************

// Sort the players by experience into two arrays
for player in players {
    if player[keyExperience] == "YES" {
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

var letters: [String] = []

for player in teamSharks {
    letters.append(draftLetter(player, teamName:sharksName))
}

for player in teamDragons {
    letters.append(draftLetter(player, teamName:dragonsName))
}

for player in teamRaptors {
    letters.append(draftLetter(player, teamName:raptorsName))
}