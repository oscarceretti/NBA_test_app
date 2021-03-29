//
//  TeamDetailView.swift
//  NBA Teams
//
//  Created by Oscar Ceretti on 29/03/2021.
//

import Foundation
import UIKit
protocol TeamDetailViewDelegate: class {
   
}

class TeamDetailView: UIView {
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

  
}
