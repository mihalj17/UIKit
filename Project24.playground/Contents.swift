import UIKit


let greeting = "Hello"


for letter in greeting {
    
    print("matko je \(letter)")
    
    
}

let letter  = greeting[greeting.index(greeting.startIndex,offsetBy: 3)]

extension String {
    
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy : 3)])
    }
}
let letter2 = greeting[3]
