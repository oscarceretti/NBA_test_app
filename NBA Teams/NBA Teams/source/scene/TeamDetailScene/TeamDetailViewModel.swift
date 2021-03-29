//
//  TeamDetailViewModel.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//


import Foundation

class TeamDetailViewModel: NSObject {

    let interactor: TeamDetailInteractorInterface
    let teamName: String
    private(set) var error: String? {
        didSet {
            guard let error = self.error else { return }
            self.bindErrorViewModelToController(error)
        }
    }
    
    private(set) var loading: Bool? {
        didSet {
            guard let loading = self.loading else { return }
            self.bindLoadingViewModelToController(loading)
        }
    }
  
    var bindErrorViewModelToController : (_ error: String) -> () = {_ in}
    var bindLoadingViewModelToController : (_ loading: Bool) -> () = { _ in }
    
    init (interactor: TeamDetailInteractorInterface, teamName: String) {
        self.interactor = interactor
        self.teamName = teamName
        self.interactor.getTeam(teamName: teamName)
    }
    
}

