//
//  ViewController.swift
//  Project12
//
//  Created by Matko Mihaljl on 19.08.2022..
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseFaceID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        defaults.set("Paul Hudson", forKey: "Name")
        defaults.set("Hello", forKey: "LastRun")
        
        let array = ["Hello","World"]
        defaults.set(array, forKey: "SavedArray")
        
        let dict = ["Name" : "Paul", "Country" : "UK"]
        defaults.set(dict, forKey: "SavedDictionary")
        
        
        let savedInteger = defaults.integer(forKey: "Age")
        let savedBoolean = defaults.bool(forKey: "UseFaceID")
        
        let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        let savedDictionary = defaults.object(forKey: "SavedDictionary") as? [String : String] ?? [String : String]()
        
        
        
    }


}

