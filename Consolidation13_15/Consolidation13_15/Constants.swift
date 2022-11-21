//
//  Constants.swift
//  Consolidation13_15
//
//  Created by Matko Mihaljl on 25.08.2022..
//

import Foundation


extension CountryListControllerTableViewController {
    struct keys {
        static let countryListAPIUrl = "https://restcountries.com/v2/all"
        static let countryCellIdentifier = "cell"
        
    }
}


extension DetailViewController {
    struct keys {
        static let countryDetailAPIUrl = "https://restcountries.com/v2/alpha/"
        static let countryDetailIdentifier = "CountryDetail"
        static let countryDetailCellIdentifier = "DetailCell"
    }
}
