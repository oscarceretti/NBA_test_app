//
//  CompositionRoot.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation
protocol TeamsListSceneFactory {
    func buildTeamListScene() -> TeamListViewController
}

protocol TeamsDetailSceneFactory {
    func buildTeamDetailScene(teamName: String) -> TeamDetailViewController
}
protocol PlayerDetailSceneFactory {
    func buildPlayerDetailScene(name: String) -> PlayerDetailViewController
}
final class CompositionRoot {
    let dependencies = AppDependencies()
}

extension CompositionRoot: TeamsListSceneFactory {
    func buildTeamListScene() -> TeamListViewController {
        let interactor = TeamListInteractor(dependencies: dependencies)
        let viewModel = TeamLstViewModel(interactor: interactor)
        let router = TeamListRouter(sceneFactory: self)
        let vc = TeamListViewController(viewModel: viewModel, router: router)
        return vc
    }
}

extension CompositionRoot: TeamsDetailSceneFactory {
    func buildTeamDetailScene(teamName: String) -> TeamDetailViewController {
        let interactor = TeamDetailInteractor(dependencies: dependencies)
        let viewModel = TeamDetailViewModel(interactor: interactor, teamName:teamName)
        let router = TeamDetailRouter(sceneFactory: self)
        let vc = TeamDetailViewController(viewModel: viewModel, router: router)
        return vc
    }
}

extension CompositionRoot: PlayerDetailSceneFactory {
    func buildPlayerDetailScene(name: String) -> PlayerDetailViewController {
        let interactor = PlayerDetailInteractor(dependencies: dependencies)
        let viewModel = PlayerDetailViewModel(interactor: interactor, teamName:name)
        let router = PlayerDetailRouter(sceneFactory: self)
        let vc = PlayerDetailViewController(viewModel: viewModel, router: router)
        return vc
    }
}
