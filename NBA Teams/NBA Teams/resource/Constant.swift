//
//  Constant.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation
struct Constants {
    struct urlPath {
        static let TEAMS_LIST = "https://free-nba.p.rapidapi.com/teams"
    }
    
    static let headers = [
        "x-rapidapi-key": "c86000c9aamsh6401e61dbd97a39p10e98cjsne09e321b9211",
        "x-rapidapi-host": "free-nba.p.rapidapi.com"
    ]
    
    struct userDefaults {
       static let LIST_KEY = "teams_list"
    }
}
