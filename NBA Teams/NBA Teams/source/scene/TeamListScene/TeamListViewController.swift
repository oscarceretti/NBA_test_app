//
//  TeamListViewController.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation
import UIKit


class TeamListViewController: UIViewController {
    
    private let viewModel: TeamLstViewModel
    private let router: TeamListRouter
    
   
    private var activityIndicator = UIActivityIndicatorView(style: .white) {
        didSet {
            activityIndicator.backgroundColor = .systemBlue
            activityIndicator.layer.cornerRadius = 20
        }
        
    }
    
    init(viewModel: TeamLstViewModel, router: TeamListRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = .white

        
        self.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let activityConstraints = [
            activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(activityConstraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUIUpdate()
        self.title = "Lista"
    }
    
    
    func callToViewModelForUIUpdate() {
        
        self.viewModel.bindErrorViewModelToController = { [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Ops", message: error, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                    alert.dismiss(animated: true)
                })
                alert.addAction(action)
                self?.present(alert, animated: true)
            }
        }
        
        self.viewModel.bindLoadingViewModelToController = { [weak self] loading in
            DispatchQueue.main.async {
                if loading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
    }
    
}


