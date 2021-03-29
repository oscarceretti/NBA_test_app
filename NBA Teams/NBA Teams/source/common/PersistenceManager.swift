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
    func save(_ list: [TeamElement], title: String) throws
    func load(title: String) throws -> [TeamElement]
}
class PeristenceManager: NSObject, PeristenceManagerProtocol{

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let userDefaults = UserDefaults.standard
    
    func save(_ list: [TeamElement], title: String) throws {
        let data = try encoder.encode(list)
        userDefaults.set(data, forKey: title)
    }
    
    func load(title: String) throws -> [TeamElement] {
        guard let data = userDefaults.data(forKey: title),
              let game = try? decoder.decode([TeamElement].self, from: data)
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
