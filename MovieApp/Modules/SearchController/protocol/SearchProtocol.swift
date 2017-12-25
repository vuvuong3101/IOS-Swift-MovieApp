//
//  SearchProtocol.swift
//  MovieApp
//
//  Created by ADMIN on 12/19/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import Foundation
protocol SearchViewProtocol: class {
    func getDataComplete()
}

protocol SearchPresenterProtocol: class {
    var isLoadMore: Bool{get set}
    var pageResult: Int?{get set}
    var searchViewModel: SearchModel?{get set}
    var textSearch: String?{get set}
    func searchWithText()
    func attachView(view : SearchViewProtocol)
    
    
}

protocol SearchSendDataProtocol: class {
    func sendDataWithModel(model: SearchViewModel)
}
