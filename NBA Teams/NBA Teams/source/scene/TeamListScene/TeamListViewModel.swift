//
//  TeamListViewModel.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation

class TeamLstViewModel: NSObject {

    let interactor: TeamListInteractorInterface
    
   
    
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

    init (interactor: TeamListInteractorInterface) {
        self.interactor = interactor
    }



}
