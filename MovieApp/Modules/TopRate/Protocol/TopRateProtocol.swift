//
//  NowPlayingProtocol.swift
//  MovieApp
//
//  Created by ADMIN on 12/17/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import Foundation
protocol TopRateProtocolForView: class {
    func loadDataSuccess()
}

protocol NowPlayingProtocolPresenter {
    func getData(index: Int)
    var modelNowList: TopRateModel?{get set}
    func attachView(view: TopRateProtocolForView)
    
}
