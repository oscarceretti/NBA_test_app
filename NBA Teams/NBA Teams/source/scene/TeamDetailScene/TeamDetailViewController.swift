//
//  TeamDetailViewController.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation
import UIKit

class TeamDetailViewController: UIViewController {
    
    private let viewModel: TeamDetailViewModel
    private let router: TeamDetailRouter
   
    private var mainView = TeamDetailView(frame: .zero)
    
    

    private var activityIndicator = UIActivityIndicatorView(style: .medium) {
        didSet {
            activityIndicator.backgroundColor = .systemBlue
            activityIndicator.layer.cornerRadius = 20
        }
        
    }
    
    init(viewModel: TeamDetailViewModel, router: TeamDetailRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
        self.mainView.viewDelegate = self
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUIUpdate()
        self.title = self.viewModel.teamName
        self.viewModel.requestPlayersList()
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
                    self?.mainView.isUserInteractionEnabled = false
                } else {
                    self?.activityIndicator.stopAnimating()
                    self?.mainView.isUserInteractionEnabled = true
                }
            }
        }
        self.viewModel.bindPlayersViewModelToController = { [weak self] players in
            self?.mainView.datasource.append(contentsOf: players)
            DispatchQueue.main.async {
                self?.mainView.reloadData()
            }
        }
    }
    
    func setLayout() {
        self.view.backgroundColor = .white
        
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        let tableConstraints = [
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(tableConstraints)
        
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
    
}

extension TeamDetailViewController: TeamDetailViewDelegate {
    func openPlayerDetail(playerName: String) {
        self.router.openPlayerDetail(from: self, name: playerName)
    }
    
    func askForMore() {
        self.viewModel.requestPlayersList()
    }
    
    
}

