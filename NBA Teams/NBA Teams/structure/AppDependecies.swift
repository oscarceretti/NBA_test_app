//
//  AppDependecies.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation

final class AppDependencies: HasNBAManager, HasNetworkManager, HasPersistenceManager{
    lazy var nbaManager: NBAManagerProtocol = NBAManager()
    lazy var networkManager: NetworkManagerProtocol = NetworkManager()
    lazy var persistenceManager: PeristenceManagerProtocol = PeristenceManager()
}
