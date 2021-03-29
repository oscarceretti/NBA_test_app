//
//  TeamListInteractor.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation

protocol TeamListInteractorInterface {
   func getTeamsList(onStart: @escaping() -> (), completion: @escaping(Result<[String]>) -> (), onComplete: @escaping() -> ())
}

final class TeamListInteractor: TeamListInteractorInterface {
    
    typealias Dependencies = HasNetworkManager & HasNBAManager & HasPersistenceManager
    let dependencies: Dependencies
    private var totalCount: Int? = nil
    init (dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    deinit{}
    
    func getTeamsList(onStart: @escaping () -> (), completion: @escaping (Result<[String]>) -> (), onComplete: @escaping () -> ()) {
        self.dependencies.networkManager.testNetwork() { (result) in
            switch result {
            
            case .success():
                
                self.dependencies.nbaManager.getTeamList(onStart: onStart, completion: { (teamsResult) in
                    switch teamsResult {
                    
                    case .success(let teams):
                        
                        do {
                            try self.dependencies.persistenceManager.save(teams.data, title: Constants.userDefaults.LIST_KEY)
                        }catch {
                            completion(.failure(error))
                        }
                        
                        completion(.success(teams.data.map { return $0.fullName }))
                        
                    case .failure(let error):
                        completion(.failure(error))
                        
                    }
                }, onComplete: onComplete)
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}


