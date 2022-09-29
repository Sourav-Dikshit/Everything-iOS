import UIKit

// SOLID Principles

// 1. Single responsibility principle -
// Source - https://www.youtube.com/watch?v=nvceoXrzDGE&list=PLb5R4QC2DtFuC7WzUd5bJP3tdVsUcI8E8&index=1

// Eg- We have to get employee data from API, Parse them to employeemodel and save it to datbase

struct EmployeeModel {
    let id: String
    let name: String
    let address: String
}

class Employee {
    
    func getEmployeeData() -> Void {
        let employeeResponse = callEmployeeApi()
        let employeeDataArray = parseApiResponse(response: employeeResponse)
        saveDataToDatabase(employeeDataArray: employeeDataArray)
    }
    
    private func callEmployeeApi() -> Data {
        
        // call to employee API and fetch Data
        return Data()
    }
    
    private func parseApiResponse(response: Data) -> Array<EmployeeModel>{
        
        // Parse Api response and return the model
        
        return Array<EmployeeModel>()
        
    }
    
    private func saveDataToDatabase(employeeDataArray: Array<EmployeeModel>) {
        // Save the data to the data array
    }
}

// Here func getEmployeeData is handling 3 responsibilities and because we have the 3 functions as private we can not test them. Let's separate them out in 3 classes

class HTTPHandler {
    
    func callEmployeeAPI()  -> Data{
        return Data()
    }
}

class Parser {
    
    func parseApiResponse(data: Data) -> Array<EmployeeModel> {
        return Array<EmployeeModel>()
    }
}

class DatabaseHandler {
    
    func saveDataToDatabase(response: Array<EmployeeModel>) {
        // Save data to database
    }
}

class Employee1 {
    let httpHandler: HTTPHandler
    let parser: Parser
    let databaseHandler: DatabaseHandler
    
    init(httpHandler: HTTPHandler, parser: Parser, databaseHandler: DatabaseHandler) {
        self.httpHandler = httpHandler
        self.parser = parser
        self.databaseHandler = databaseHandler
    }
    
    func getEmployeeData() -> Void {
        
        let response = httpHandler.callEmployeeAPI()
        let employeeData = parser.parseApiResponse(data: response)
        databaseHandler.saveDataToDatabase(response: employeeData)
    }
    
}
 
let objEmployee = Employee1(httpHandler: HTTPHandler(), parser: Parser(), databaseHandler: DatabaseHandler())


// Benefits -
// i. Neat Code.
// ii. Can test individual functions now.
// iii. Each class is responsible for each responsibility.


// 2. Open & Closed principle
// Source:- https://www.youtube.com/watch?v=WJznwyuOHZc&list=PLb5R4QC2DtFuC7WzUd5bJP3tdVsUcI8E8&index=3

// i. Open & closed principle means open for extension and closed for modification.
// ii. Use protocols for declaring functions and classes will extend it.

protocol Shape {
    func calculateArea() -> Double
}


// These Classes Rectangle and Circle & Tringle are open for extension by extending Shape Protocol
class Rectangle: Shape {
    let width: Double
    let height: Double
    
    init (width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    
    func calculateArea() -> Double {
        return height * width
    }
}

class Circle: Shape {
    let radious: Double
    
    init (radious: Double) {
        self.radious = radious
    }
    
    func calculateArea() -> Double {
        return Double.pi * radious * radious
    }
}

class Tringle: Shape {
    let base: Double
    let height: Double
    
    init(base: Double, height: Double){
        self.base = base
        self.height = height
    }
    
    func calculateArea() -> Double {
        return 1/2 * base * height
    }
}

class AreaCalculator {
   
    func area(shape: Shape) {
       print(shape.calculateArea())
    } // This function is closed for modification
}


let objAreaCalculator = AreaCalculator()
let objRectangle = Rectangle(width: 2, height: 3)
let objTringle = Tringle(base: 5, height: 6)
objAreaCalculator.area(shape: objTringle)


// 3. LSV - Liskov's substitution principle
// Source - https://www.youtube.com/watch?v=VAA6lZsODh4&list=PLb5R4QC2DtFuC7WzUd5bJP3tdVsUcI8E8&index=4

// i. Child class should not modify anything of parent class in inheritance. Base class should be used as it is.

// Let's break Liskov's substitution principle

class Rectangle1 {
    var width: Double = 0
    var length: Double = 0
    
    var area: Double {
        return width * length
    }
}

class Squre: Rectangle1 {
    
    override var width : Double {
        didSet {
            length = width
        }
    }
}

let objRecta = Rectangle1()
objRecta.width = 5
objRecta.length = 6

print(objRecta.area)

let objSqure = Squre()
objSqure.width = 5

print(objSqure.area)

// Here we are breaking LSV because we are modifying base class variable in child class. Let's make it more clean

protocol Shape1 {
    var area: Double { get }
}

class Rectangle2: Shape1 {
    var width: Double = 0
    var length: Double = 0
    
    var area: Double {
        return width * length
    }
}

class Squre1: Shape1 {
    var width: Double = 0
    
    var area: Double {
        return width * width
    }
}

let objRecta1 = Rectangle2()
objRecta1.width = 5
objRecta1.length = 6

print(objRecta1.area)

let objSqure1 = Squre()
objSqure1.width = 5

print(objSqure.area)


// 4. Interface Segregation Principle


// If you are not careful with protocols we may end up getting fat protocol issue.

protocol Humans {
    func goToWork()
    func buyHouse()
    func eat()
    func sleep()
}

class Person: Humans {
    func goToWork() {
        print("A person goes to work")
    }
    
    func buyHouse() {
        print("A person buy a house")
    }
    
    func eat() {
        print("A person eats")
    }
    
    func sleep() {
        print("A person sleeps")
    }
}

class Lion: Humans {
    func goToWork() {
        <#code#>
    } //Extra Functionality
    
    func buyHouse() {
        <#code#>
    } //Extra Functionality
    
    func eat() {
        <#code#>
    }
    
    func sleep() {
        <#code#>
    }
}

// Here Lion implements Humans but it has extra set of functionalities that a class Lion does not need because Lion does not go to work or it does not but a house either. So this is Fat protocol issue. Make sure class has only those functionalities which class needs.
// Let's see how to resolve fat protocol prob,

protocol Mamal {
    func eat()
    func sleep()
}

protocol Human: Mamal {
    func goToWork()
    func buyAHouse()
}

protocol Animal: Mamal {
    func hunt()
}

class Person1: Human {
    func goToWork() {
        <#code#>
    }
    
    func buyAHouse() {
        <#code#>
    }
    
    func eat() {
        <#code#>
    }
    
    func sleep() {
        <#code#>
    }
}

class Lion1: Animal {
    func hunt() {
        <#code#>
    }
    
    func eat() {
        <#code#>
    }
    
    func sleep() {
        <#code#>
    }
}

// Dependency Inversion Principle
