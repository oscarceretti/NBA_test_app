//
//  TeamListInteractor.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation

protocol TeamListInteractorInterface {
   
}

final class TeamListInteractor: TeamListInteractorInterface {
    typealias Dependencies = HasNBAManager
    let dependencies: Dependencies
    
    private var totalCount: Int? = nil
    init (dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    deinit{}
    

    
    
}


