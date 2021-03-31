//
//  PlayerDetailRouter.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 30/03/2021.
//

import Foundation

import UIKit

protocol PlayerDetailRouterProtocol {
    func openPlayerDetail(from: UIViewController, name: String)
}
final class PlayerDetailRouter: PlayerDetailRouterProtocol {
    
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
