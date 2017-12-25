//
//  UpComingProtocol.swift
//  MovieApp
//
//  Created by ADMIN on 12/17/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import Foundation
protocol UpComingViewProtocol: class {
    func loadDataSuccessed()
}

protocol UpComingPresenterProtocol: class {
    var upComingModel: UpComingModel?{get set}
    var currentPage: Int?{get set} 
    func getData(index: Int)
    func attachView(view: UpComingViewProtocol)
}
