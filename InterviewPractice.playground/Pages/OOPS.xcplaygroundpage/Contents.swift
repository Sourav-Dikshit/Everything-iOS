import UIKit


//1. OOPS Concepts
// Source - https://medium.com/swift-india/oops-in-swift-998738407423

// class
class Person {
    // Person's abilities can be defined here!
    // Don't write anything if you are a vampire ha ha
    
    //Properties
    let age: Int!
    let name: String!
    let gender: String!
    let maritialStatus: String!
    
    //Initializers
    init (age: Int,name: String, gender: String, maritialStatus: String) {
        self.age = age
        self.name = name
        self.gender = gender
        self.maritialStatus = maritialStatus
    }
    
    // Methods
    func play (sport: String) {
        print("\(name.description) is playing \(sport)")
    }
    
    // Method overloading
    func play(instrument: String) {
        print("\(name.description) is playing \(instrument)")
    }
    
}
// Object
let sourav = Person(age: 27, name: "Sourav", gender: "Male", maritialStatus: "Single") // Here we are instantiating the class Person
sourav.play(sport: "Cricket") // calling person method

// UIView is a class and backgroundColor, isHidden, Frame as properties
// Methods- UIView class has method setNeedsLayout() that we call if want to forcefully reset the UI layout.

// Encapsulation - We hide data and methods from outside intervention and usage

class Maths {
    let a: Int!
    let b: Int!
    
    private var result: Int?
    
    init (a: Int, b: Int) {
        self.a = a
        self.b = b
    }
    
    func add() {
        result = a + b
    }
    
    func displayResult() {
        print ("The result is \(result ?? 0)")
    }
}

let calculation = Maths(a: 2, b: 3)
calculation.add()
calculation.displayResult()

// What we did here -
// We hide the result variable from outside intervention and usage and provided a different method to display it

// Abstraction -
// Only show the relevent data and methods and hide the internal implementation
// In encapsulation example what we did was we are exposing add() and displayResult() to the user and hiding how it is being done internally.

// Inheritance - Child inherits properties and behaviour of its parent

class Men: Person {
    
    // Method overriding
    override init(age: Int, name: String, gender: String, maritialStatus: String) {
        // Behaves differently from the Parent init
        super.init(age: age, name: name, gender: gender, maritialStatus: maritialStatus)
        
        // Do additional things here
        
    }
}

let men = Men(age: 25, name: "Virat", gender: "Male", maritialStatus: "Married") // Since Men inherits from Person it gets all the properties of Person class bydefault


// Method Overloading
// A class can have two or more methods having same method name but different parameters. Eg- Class Person has two methods Play() having diff arguments.

// Method Overriding - Eg- We override viewDidLoad() when we inherit UIViewController


// Polymorphism -
// Same object can behave differently


class Player {
    let name:  String
    
    init(name: String){
        self.name = name
    }
    
    func play() {
    }
}

class Batsman: Player {
    override func play() {
        bat()
    }
    
    func bat() {
        print("\(name) is Batting")
    }
}

class Bowler: Player {
    override func play() {
        bowl()
    }
    
    func bowl() {
        print("\(name) is Bowling")
    }
}

class CricketTeam {
    let name: String
    var players: [Player]
    
    init (name: String, players: [Player]) {
        self.name = name
        self.players = players
    }
    
    func play () {
        for player in players {
            player.play()
        }
    }
}

let viratKohli = Batsman(name: "Virat Kohli")
let bhumrah = Bowler(name: "Jashprit Bhumrah")

let indianCricketTeam = CricketTeam(name: "IndianCricketTeam", players: [viratKohli, bhumrah])
indianCricketTeam.play()
