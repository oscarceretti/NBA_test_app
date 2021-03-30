//
//  Array+Extension.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 30/03/2021.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
