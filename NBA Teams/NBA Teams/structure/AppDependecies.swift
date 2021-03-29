//
//  AppDependecies.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation

final class AppDependencies: HasNBAManager {
    lazy var nbaManager: NBAManagerProtocol = NBAManager()
}
