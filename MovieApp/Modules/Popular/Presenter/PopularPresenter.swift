//
//  PopularPresenter.swift
//  MovieApp
//
//  Created by ADMIN on 12/17/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import Foundation
class PopularPresenter: PopularPresenterPotocol{
    var popularModel: PopularModel?
    var currentPage = 1
    fileprivate var presenter: PopularProtocolForView?
    func getData(index: Int) {
        MAWebServirce.shareInstance.sendGETRequest(path: "https://api.themoviedb.org/3/movie/popular?api_key=437aa21c2934a238513bec5adfe05a4a&language=vi-VN&page=\(index)", params: nil,headers: nil, responseObjectClass: PopularListModel()) { [weak self] success , response in
            
            if(success) {
                guard let data = response as? PopularListModel else {
                    return
                }
                self?.popularModel = PopularModel()
                self?.popularModel?.popularModel = data
                self?.presenter?.loadDataComplete()
                
                
            }
            
        }
    }
    
    func attachView(view: PopularProtocolForView) {
        self.presenter = view
    }
    
    
}
