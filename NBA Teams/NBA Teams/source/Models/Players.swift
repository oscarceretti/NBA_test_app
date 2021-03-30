//
//  Players.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 30/03/2021.
//

import Foundation

// MARK: - PlayersContainer
struct PlayersContainer: Codable {
    let data: [Player]
    let meta: Meta
}

// MARK: - Datum
struct Player: Codable {
    let id: Int
    let firstName: String
    let heightFeet, heightInches: Int?
    let lastName: String
    let position: String?
    let team: TeamElement
    let weightPounds: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case heightFeet = "height_feet"
        case heightInches = "height_inches"
        case lastName = "last_name"
        case position, team
        case weightPounds = "weight_pounds"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let totalPages, currentPage, nextPage, perPage: Int?
    let totalCount: Int?

    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case currentPage = "current_page"
        case nextPage = "next_page"
        case perPage = "per_page"
        case totalCount = "total_count"
    }
}

struct PlayerEntity: Codable,Hashable{
    
    let id: Int
    let fullName: String
    let teamId: Int

    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case teamId
    }
}
