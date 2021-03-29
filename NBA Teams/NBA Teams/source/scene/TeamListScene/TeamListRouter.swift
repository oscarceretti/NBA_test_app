//
//  TeamListRouter.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation
import UIKit
protocol TeamListRouterProtocol {
    func openTeamDetail(from: UIViewController, teamName: String)
}
final class TeamListRouter: TeamListRouterProtocol {
    
    func openTeamDetail(from: UIViewController, teamName: String) {
        debugPrint(teamName)
    }
    
    typealias SceneFactory = TeamsListSceneFactory
    let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory){
        self.sceneFactory = sceneFactory
    }
    
    func openTeamDetail(from: UIViewController) {
        
    }
    
    
}

