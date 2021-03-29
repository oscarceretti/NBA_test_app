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


