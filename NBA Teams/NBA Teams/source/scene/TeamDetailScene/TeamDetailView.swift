//
//  TeamDetailView.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation
import UIKit

protocol TeamDetailViewDelegate: class {
    func openPlayerDetail(playerName: String)
    func askForMore()
}

class TeamDetailView: UITableView,UITableViewDataSource, UITableViewDelegate {
    
    private let cellID = "PlayerListCell__"
    var viewDelegate: TeamDetailViewDelegate?
    var datasource: [String] = []
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame,style: style)
        self.backgroundColor = .white
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        self.delegate = self
        self.dataSource = self
        self.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = datasource[indexPath.row]
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewDelegate?.openPlayerDetail(playerName: datasource[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == datasource.count - 1 {
            self.viewDelegate?.askForMore()
        }
    }
}
