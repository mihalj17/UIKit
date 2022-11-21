//
//  Country.swift
//  Consolidation13_15
//
//  Created by Matko Mihaljl on 24.08.2022..
//

import UIKit
import Foundation

class Country: Codable {
    var name: String
    var topLevelDomain: [String]?
    var alpha2Code, alpha3Code: String?
    var callingCodes: [String]?
    var capital: String?
    var altSpellings: [String]?
    var subregion, region: String?
    var population: Int?
    var latlng: [Double]?
    var demonym: String?
    var area: Double?
    var timezones, borders: [String]?
    var nativeName, numericCode: String?
    var flag: String?
    var cioc: String?
    var independent: Bool?
    
}
