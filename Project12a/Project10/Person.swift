//
//  Person.swift
//  Project10
//
//  Created by Matko Mihaljl on 17.08.2022..
//

import UIKit

class Person: NSObject , NSCoding{
    var name : String
    var image : String
    
    init(name : String , image: String){
        self.image = image
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder){
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image,forKey: "image")
    }
}
