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
        let vc = self.sceneFactory.buildTeamDetailScene(teamName: teamName)
        from.navigationController?.pushViewController(vc, animated: true)
    }
    
    typealias SceneFactory = TeamsDetailSceneFactory
    let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory){
        self.sceneFactory = sceneFactory
    }
    
}

