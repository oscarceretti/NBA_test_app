//
//  TeamDetailInteractor.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation

protocol TeamDetailInteractorInterface {
    func getPlayers(teamName: String, onStart: @escaping () -> (), completion: @escaping (Result<[String]>) -> (), onComplete: @escaping () -> ())
}

final class TeamDetailInteractor: TeamDetailInteractorInterface {
    
    
    
    typealias Dependencies = HasNetworkManager & HasNBAManager & HasPersistenceManager
    let dependencies: Dependencies
    var nextPage: Int? = 1
    init (dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    deinit{}
    

    func getPlayers(teamName: String, onStart: @escaping () -> (), completion: @escaping (Result<[String]>) -> (), onComplete: @escaping () -> ()) {
        do {
            guard let next = nextPage else { return }
            let id = try self.dependencies.persistenceManager.loadTeams().filter { $0.fullName == teamName }.map({ $0.id}).first
            self.dependencies.nbaManager.getPLayerList(page: next, onStart: onStart, completion: { (result) in
                switch result {
                
                case .success(let playerContainer):
                    self.nextPage = playerContainer.meta.nextPage
                    let playerEntity = self.parsePlayer(players: playerContainer.data)
                    do {
                        var players = try self.dependencies.persistenceManager.loadPlayers()
                        players.append(contentsOf: playerEntity)
                        
                        try self.dependencies.persistenceManager.savePlayers(players.uniqued())
                        let filtered = self.filterTeamPlayer(players: playerEntity, teamId: id).uniqued()
                        self.responseHaveSomeTeamPlayer(filtered: filtered, teamName: teamName, onStart: onStart, completion: completion, onComplete: onComplete)
                        
                    }catch {
                        do {
                            try self.dependencies.persistenceManager.savePlayers(playerEntity)
                            let filtered = self.filterTeamPlayer(players: playerEntity, teamId: id).uniqued()
                            self.responseHaveSomeTeamPlayer(filtered: filtered, teamName: teamName, onStart: onStart, completion: completion, onComplete: onComplete)
                        } catch {
                            completion(.failure(error))
                        }
                    }
                    
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }, onComplete: onComplete)
        }catch {
            completion(.failure(error))
        }
        
    }
    
    func parsePlayer(players: [Player]) -> [PlayerEntity] {
        let entity = players.map { (player) -> PlayerEntity in
            return PlayerEntity(id: player.id, fullName: "\(player.firstName) \(player.lastName)", teamId: player.team.id)
        }
        return entity
    }
    
    func filterTeamPlayer(players: [PlayerEntity], teamId: Int?) -> [String] {
        return players.filter({ $0.teamId == teamId }).map({ $0.fullName })
    }
    
    func responseHaveSomeTeamPlayer( filtered: [String],teamName: String, onStart: @escaping () -> (), completion: @escaping (Result<[String]>) -> (), onComplete: @escaping () -> ()) {
        if !filtered.isEmpty {
            completion(.success(filtered))
        }else {
            self.getPlayers(teamName: teamName, onStart: onStart, completion: completion, onComplete: onComplete)
        }
    }
}




