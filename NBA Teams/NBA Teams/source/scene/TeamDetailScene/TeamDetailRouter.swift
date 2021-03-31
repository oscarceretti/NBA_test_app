//
//  TeamDetailRouter.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation
import UIKit

protocol TeamDetailRouterProtocol {
    func openPlayerDetail(from: UIViewController, name: String)
}
final class TeamDetailRouter: TeamDetailRouterProtocol {
    
    func openPlayerDetail(from: UIViewController, name: String) {
        let vc = self.sceneFactory.buildPlayerDetailScene(name: name)
        from.navigationController?.pushViewController(vc, animated: true)
    }
    
    typealias SceneFactory = PlayerDetailSceneFactory
    let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory){
        self.sceneFactory = sceneFactory
    }

    
}
