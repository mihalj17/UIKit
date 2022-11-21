//
//  Note.swift
//  ConslidationVIII
//
//  Created by Matko Mihaljl on 02.09.2022..
//

import UIKit

class Note: NSObject , Codable {
    var title: String
    var body: String
    
    init(title: String, body: String){
        self.title = title
        self.body = body
    }
}
