//
//  TeamDetailInteractor.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation

protocol TeamDetailInteractorInterface {
    func getTeam(teamName: String)
}

final class TeamDetailInteractor: TeamDetailInteractorInterface {

    
    
    typealias Dependencies = HasNetworkManager & HasNBAManager & HasPersistenceManager
    let dependencies: Dependencies
    
    init (dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    deinit{}
    
    func getTeam(teamName: String) {
        do {
            let id = try self.dependencies.persistenceManager.load(title: Constants.userDefaults.LIST_KEY).filter { $0.fullName == teamName }.map({ (element) -> String in
                String(element.id)
            }).first
            
        }catch {
            debugPrint(error)
        }
        
    }
    
    
}



