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
    func getCount() -> UInt
    {
      return green + yellow + red
    }  
}

func winner(_ players:[Player]) -> [String]
{
  var w:[String] = []
  var w_points = 13
  for p in players
  {
    if(p.points < w_points)
    {
      w.removeAll()
      w.append(p.name)
      w_points = p.points
    }
    else if(p.points = w_points)
    {
      w.append(p.name)
    }
  }
  return w
}

func game()
{
    var num_players = 0
    var players:[Player] = []
    repeat
    {
        print("Enter number of players(2..8):")
        if let input = readLine()
        {
            if let int = Int(input)
            {
               num_players = int 
            }
        }        
    } while(num_players < 2 || num_players > 8)
    
    for i in 1 ... num_players
    {
      while true
      {
        print("Enter name of player \(i):")
        if let input = readLine()
        {
          if(input.length < 0)
          {
            players.append(Player(name:input,points:0))
            break;
          }
        }
      }
    }
    var new_game = true
    while new_game = true
    {
      for i in 0..<num_players
      {
        players[i].reset()
      }
      var turn = 0
      repeat
      {
        for p in players
        {
          print("\(p.name) - \(p.points) points")
        }
        print("\(players[turn%num_players].name)'s turn:")
        var dice = Dice(green: 6, yellow: 4, red: 3)
        var points = 0
        var shotguns = 0
        while dice.getCount() >= 3 && shotguns < 3
        {
          let d_arr = dice.draw(3)
          var runners = false
          for i in 0...2
          {
            let r = d_arr[i].0.roll()
            if(r == "🧠")
            {
              points += 1
            }
            else if(r == "💥")
            {
              shotguns += 1
            }
            else
            {
              runners = true
              if(d_arr[i].1 == "green")
              {
                dice.green += 1
              }
              else if(d_arr[i].1 == "yellow")
              {
                dice.yellow += 1
              }
              else
              {
                dice.red += 1
              }
            }
            print("Die#\(i+1)(\(d_arr[i].1)) - \(r)")
          }
          if(shotguns > 2)
          {
            break;
          }
          if(runners == true)
          {
            var answer = ""
            repeat
            {
              print("Roll again(roll) / End Turn(end):")
              if let input = readLine()
              {
                answer = input
              }        
            } while(answer != "roll" && answer != "end")
            if(answer == "end")
            {
              players[turn%num_players].points += points
              break;
            }
          }
          else
          {
            players[turn%num_players].points += points
            break;
          }
        }
        turn += 1
      } while(!(turn%num_players == 0 && winner(players).count != 0))
      print("The winner is \(winner(players))")
      var answer = ""
      repeat
      {
        print("New game? (yes/no):")
        if let input = readLine()
        {
          answer = input
        }        
      } while(answer != "yes" && answer != "no")
      if(answer == "no")
      {
        new_game = false 
      }
    }
}

game()