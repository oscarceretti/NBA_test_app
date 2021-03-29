//
//  TeamListViewController.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation
import UIKit


class TeamListViewController: UIViewController, UITableViewDelegate {
    
    private let viewModel: TeamLstViewModel
    private let router: TeamListRouter
    private var dataSource: [String] = []
    
    private var teamList = UITableView() {
        didSet {
            teamList.backgroundColor = .white
        }
    }
    private let cellID = "TeamListCell__"
    private var activityIndicator = UIActivityIndicatorView(style: .medium) {
        didSet {
            activityIndicator.backgroundColor = .systemBlue
            activityIndicator.layer.cornerRadius = 20
        }
        
    }
    
    init(viewModel: TeamLstViewModel, router: TeamListRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupTableView()
        super.viewDidLoad()
        callToViewModelForUIUpdate()
        self.viewModel.callFuncToGetTeamsList()
        self.title = "Lista"
    }
    
    func setupTableView() {
        teamList.delegate = self
        teamList.dataSource = self
        teamList.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    func callToViewModelForUIUpdate() {
        
        self.viewModel.bindTeamsViewModelToController = { [weak self] teams in
            self?.dataSource = teams
            DispatchQueue.main.async {
                self?.teamList.reloadData()
            }
        }
        
        
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
    
    func setLayout() {
        self.view.backgroundColor = .white
        
        view.addSubview(teamList)
        teamList.translatesAutoresizingMaskIntoConstraints = false
        let tableConstraints = [
            teamList.topAnchor.constraint(equalTo: view.topAnchor),
            teamList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            teamList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            teamList.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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


extension TeamListViewController: UITableViewDataSource {
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
    cell.textLabel?.text = dataSource[indexPath.row]
    return cell
  }
    
}
