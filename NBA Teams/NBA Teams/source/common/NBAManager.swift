//
//  NBAManager.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation


protocol HasNBAManager {
    var nbaManager: NBAManagerProtocol { get }
}

protocol NBAManagerProtocol {
    
}
class NBAManager: NSObject, NBAManagerProtocol{
    
    
    override init() {
        super.init()
        
    }
    
    
}
