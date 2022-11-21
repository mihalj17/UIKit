//
//  Person.swift
//  Project10
//
//  Created by Matko Mihaljl on 17.08.2022..
//

import UIKit

class Person: NSObject {
    var name : String
    var image : String
    
    init(name : String , image: String){
        self.image = image
        self.name = name
    }
}
