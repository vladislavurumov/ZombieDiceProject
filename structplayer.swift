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