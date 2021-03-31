//
//  NetworkManager.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation
import Network


protocol HasNetworkManager {
    var networkManager: NetworkManagerProtocol { get }
}

protocol NetworkManagerProtocol {
    func testNetwork(completion: @escaping(Result<()>) -> ())
}
class NetworkManager: NSObject, NetworkManagerProtocol{


    let monitor = NWPathMonitor()
    
    
    func testNetwork(completion: @escaping (Result<()>) -> ()){
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                completion(.success(()))
            } else {
                completion(.failure(MyError.network))
            }
            print(path.isExpensive)
        }
    }
    
    
    
    

    override init() {
        super.init()
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    
}
