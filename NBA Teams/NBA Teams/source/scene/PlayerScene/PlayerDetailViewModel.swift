//
//  PlayerDetailViewModel.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 30/03/2021.
//

import Foundation


class PlayerDetailViewModel: NSObject {
    
    let interactor: PlayerDetailInteractorInterface
    let teamName: String
    
    private(set) var player: [String]? {
        didSet {
            guard let player = self.player else { return }
            self.bindPlayerViewModelToController(player)
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
    var bindPlayerViewModelToController : (_ players: [String]) -> () = { _ in }
    
    init (interactor: PlayerDetailInteractorInterface, teamName: String) {
        self.interactor = interactor
        self.teamName = teamName
    
    }
    func requestPlayersList(){
        self.interactor.getPlayer(name: teamName) {
            self.loading = true
        } completion: { (result) in
            switch result {
            
            case .success(let player):
                self.player = player
            case .failure(let error):
                self.error = error.localizedDescription
            }
        } onComplete: {
            self.loading = false
        }
    }
}
