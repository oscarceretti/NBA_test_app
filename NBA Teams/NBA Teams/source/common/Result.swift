//
//  Result.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure (Error)
}

