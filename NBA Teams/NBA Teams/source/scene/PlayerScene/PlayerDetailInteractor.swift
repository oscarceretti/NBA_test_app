//
//  PlayerDetailInteractor.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 30/03/2021.
//

import Foundation

protocol PlayerDetailInteractorInterface {
    func getPlayer(name: String, onStart: @escaping () -> (), completion: @escaping (Result<[String]>) -> (), onComplete: @escaping () -> ())
}

final class PlayerDetailInteractor: PlayerDetailInteractorInterface {
    
    
    
    typealias Dependencies = HasNetworkManager & HasNBAManager & HasPersistenceManager
    let dependencies: Dependencies

    init (dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    deinit{}
    

    func getPlayer(name: String, onStart: @escaping () -> (), completion: @escaping (Result<[String]>) -> (), onComplete: @escaping () -> ()) {
        do {
            
            guard let id = try self.dependencies.persistenceManager.loadPlayers().filter({ $0.fullName == name }).map({ $0.id}).first else { return }
            self.dependencies.nbaManager.getPlayer(id: id, onStart: onStart, completion: { (result) in
                switch result {
                
                case .success(let player):
                    completion(.success(self.parsePlayerToDescription(player: player)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }, onComplete: onComplete)
        }catch {
            completion(.failure(error))
        }
        
    }
    
    
    func parsePlayerToDescription(player: Player) -> [String]{
        var descriptionArray:[String] = []
        descriptionArray.append("Nome: \(player.firstName)")
        descriptionArray.append("Cognome: \(player.lastName)")
        if let heightFeet = player.heightFeet , let heightInches = player.heightInches {
            descriptionArray.append("Altezza: \(heightFeet) feet e \(heightInches) inch")
        }
        if let weightPounds = player.weightPounds {
            descriptionArray.append("Peso: \(weightPounds) lbs")
        }
        if let position = player.position, !position.isEmpty {
            descriptionArray.append("Posizione: \(position)")
        }
        return descriptionArray
    }
  
}




