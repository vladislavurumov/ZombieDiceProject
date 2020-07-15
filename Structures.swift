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
    func roll() -> String
    {
        let number = UInt.random(in: 1 ... sum)
        if(number <= brains)
        {
            return "🧠"
        }
        else if(number <= brains  + runners)
        {
            return "👣"
        }
        else
        {
            return "💥"
        }
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
    mutating func draw(_ _count: UInt) -> [(Die,String)]
    {
        var result: [(Die,String)] = []
        var count = _count
        while count > 0 && green + yellow + red > 0 
        {
            let number = UInt.random(in: 1 ... (green + yellow + red))
            if(number <= green)
            {
                result.append((Die(brains: 3, runners: 2, shotguns: 1),"green"));
                green -= 1
            }
            else if(number <= green  + yellow)
            {
                result.append((Die(brains: 2, runners: 2, shotguns: 2),"yellow"));
                yellow -= 1
            }
            else
            {
                result.append((Die(brains: 1, runners: 2, shotguns: 3),"red"));
                red -= 1
            }
            count -= 1
        }
        return result
    }
}

