//
//  NBAManager.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation
import Network

enum MyError: Error {
    case network
}

protocol HasNBAManager {
    var nbaManager: NBAManagerProtocol { get }
}

protocol NBAManagerProtocol {
    func getTeamList(onStart: @escaping() -> (), completion: @escaping(Result<Teams>) -> (), onComplete: @escaping() -> ())
    func getPLayerList(page: Int, onStart: @escaping() -> (), completion: @escaping(Result<PlayersContainer>) -> (), onComplete: @escaping() -> ())
}
class NBAManager: NSObject, NBAManagerProtocol{
    
    override init() {
        super.init()
    }
    
    func getTeamList(onStart: @escaping () -> (), completion: @escaping (Result<Teams>) -> (), onComplete: @escaping () -> ()) {
        onStart()
        
        let request = NSMutableURLRequest(url: NSURL(string: Constants.urlPath.TEAMS_LIST)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = Constants.headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            onComplete()
            do {
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    let teams = try jsonDecoder.decode(Teams.self, from: data)
                    completion(.success(teams))
                }else {
                    completion(.failure(error!))
                }
            }catch {
                completion(.failure(error))
            }
        })
        dataTask.resume()
    }
    

    func getPLayerList(page: Int,onStart: @escaping () -> (), completion: @escaping (Result<PlayersContainer>) -> (), onComplete: @escaping () -> ()) {
        onStart()
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://free-nba.p.rapidapi.com/players?page=\(page)&per_page=100")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = Constants.headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            onComplete()
            do {
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    let players = try jsonDecoder.decode(PlayersContainer.self, from: data)
                    completion(.success(players))
                }else {
                    completion(.failure(error!))
                }
            }catch {
                completion(.failure(error))
            }
        })
        dataTask.resume()
    }
    
    
}
