//
//  PopularProtocol.swift
//  MovieApp
//
//  Created by ADMIN on 12/17/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import Foundation

protocol PopularProtocolForView {
    func loadDataComplete()
}

protocol PopularPresenterPotocol: class {
    var popularModel: PopularModel?{get set}
    func getData(index: Int)
    func attachView(view: PopularProtocolForView)
    
}
