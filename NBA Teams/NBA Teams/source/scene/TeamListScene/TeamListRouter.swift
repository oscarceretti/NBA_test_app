//
//  TeamListRouter.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation
import UIKit
protocol TeamListRouterProtocol {
    func openTeamDetail(from: UIViewController)
}
final class TeamListRouter: TeamListRouterProtocol {
    

    

    
    typealias SceneFactory = TeamsListSceneFactory
    let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory){
        self.sceneFactory = sceneFactory
    }
    
    func openTeamDetail(from: UIViewController) {
        
    }
    
    
}

