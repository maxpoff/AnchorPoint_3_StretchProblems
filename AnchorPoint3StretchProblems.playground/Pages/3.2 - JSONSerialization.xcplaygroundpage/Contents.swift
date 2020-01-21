//: [Previous](@previous)

/*:
 # Tuesday Stretch Problem 3.2
 ## JSONSerialization
 
 ### Instructions:
 * Create a person class with four properties: **name**, **age**, **hasLice**, and **siblingNames**. Choose the correct types for each.
 * Make a failable initializer that takes in a dictionary of type String : Any.
 * Test this initializer on the *testDictionary* to make sure it works.
 
 ### Instructions continued
 * Read about [JSONSerialization](https://developer.apple.com/documentation/foundation/jsonserialization)
 * Use a Do/Try/Catch to do the following steps:
    * Use the JSONSerialization class to deserialize the *data* using the jsonObject function.
    * Cast the result of the jsonObject function into a [String: Any] dictionary and use it to initialize a Person
 */

import UIKit

let testDictionary: [String: Any] = ["name":"Derek","age":28,"hasLice":false,"timeSinceBirth":28.2345,"siblingNames":["Eve","Harmon","Gerald","Marty"]]

let jsonString = """

{

"name": "Derek",

"age": 28,

"hasLice": false,

"timeSinceBirth": 28.2345,

"siblingNames": ["Eve","Harmon","Gerald","Marty"]

}

"""

let data = jsonString.data(using: .utf8, allowLossyConversion: false)!

class Person {
    var name: String
    var age: Int
    var hasLice: Bool
    var siblingNames: [String]
    
    init?(dictionary: [String:Any]) {
        guard let name = dictionary["name"] as? String,
        let age = dictionary["age"] as? Int,
        let hasLice = dictionary["hasLice"] as? Bool,
        let siblingNames = dictionary["siblingNames"] as? [String]
        else {return nil}
        
        self.name = name
        self.age = age
        self.hasLice = hasLice
        self.siblingNames = siblingNames
    }
}//End of class

let derek = Person(dictionary: testDictionary)

func serializeJSON(data: Data) -> Person? {
    var serializedPerson: Person?
    do {
        guard var topLevelDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] else { return nil }
        let person = Person(dictionary: topLevelDictionary)
        serializedPerson = person
    } catch {
        print("There was an error serializing the JSON : \(error.localizedDescription)")
        return nil
    }
    return serializedPerson
}
let derekJSON = serializeJSON(data: data)



//: [Next](@next)
