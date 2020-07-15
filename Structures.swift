import Foundation

struct Player
{
    let name: String
    var points: Int
    init()
    {
        self.name = ""
        self.points = 0
    }
    init(name:String, points: Int )
    {
        self.name = name
        self.points = points
    }
    mutating func reset() 
    {
        self.points = 0
    }
}

struct Die
{
    let brains: UInt
    let runners: UInt
    let shotguns: UInt
    let sum: UInt
    init(brains: UInt, runners: UInt, shotguns: UInt)
    {
        self.brains = brains
        self.runners = runners
        self.shotguns = shotguns
        self.sum = brains + runners + shotguns
    }
}
struct Dice
{
    var green: UInt
    var yellow: UInt
    var red: UInt
    init(green: UInt, yellow: UInt, red: UInt)
    {
        self.green = green
        self.yellow = yellow
        self.red = red
    }
    
}

