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
