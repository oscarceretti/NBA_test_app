//
//  PersistenceManager.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation
protocol HasPersistenceManager {
    var persistenceManager: PeristenceManagerProtocol { get }
}

protocol PeristenceManagerProtocol {
    func saveTeams(_ list: [TeamElement]) throws
    func loadTeams() throws -> [TeamElement]
    func savePlayers(_ list: [PlayerEntity]) throws
    func loadPlayers() throws -> [PlayerEntity]
}
class PeristenceManager: NSObject, PeristenceManagerProtocol{

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let userDefaults = UserDefaults.standard
    
    func saveTeams(_ list: [TeamElement]) throws {
        let data = try encoder.encode(list)
        userDefaults.set(data, forKey: Constants.userDefaults.LIST_KEY)
    }
    
    func loadTeams() throws -> [TeamElement] {
        guard let data = userDefaults.data(forKey: Constants.userDefaults.LIST_KEY),
              let game = try? decoder.decode([TeamElement].self, from: data)
        else {
            throw Error.listNotFound
        }
        return game
    }
    func savePlayers(_ list: [PlayerEntity]) throws {
        let data = try encoder.encode(list)
        userDefaults.set(data, forKey: Constants.userDefaults.PLAYERS_KEY)
    }
    
    func loadPlayers() throws -> [PlayerEntity] {
        guard let data = userDefaults.data(forKey: Constants.userDefaults.PLAYERS_KEY),
              let game = try? decoder.decode([PlayerEntity].self, from: data)
        else {
            throw Error.listNotFound
        }
        return game
    }
    public enum Error: String, Swift.Error {
        case listNotFound
    }
    
    override init() {
        super.init()
        
    }
    
    
}
