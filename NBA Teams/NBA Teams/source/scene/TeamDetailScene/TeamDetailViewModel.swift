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
    
    private(set) var players: [String]? {
        didSet {
            guard let players = self.players else { return }
            self.bindPlayersViewModelToController(players)
        }
    }
    
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
    var bindPlayersViewModelToController : (_ players: [String]) -> () = { _ in }
    
    init (interactor: TeamDetailInteractorInterface, teamName: String) {
        self.interactor = interactor
        self.teamName = teamName
    
    }
    func requestPlayersList(){
        self.interactor.getPlayers(teamName: teamName) {
            self.loading = true
        } completion: { (result) in
            switch result {
            
            case .success(let players):
                self.players = players
            case .failure(let error):
                self.error = error.localizedDescription
            }
        } onComplete: {
            self.loading = false
        }
    }
}
