//
//  UpComingPresenter.swift
//  MovieApp
//
//  Created by ADMIN on 12/17/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import Foundation
class UpComingPresenter: UpComingPresenterProtocol{
    var currentPage: Int?
    var upComingModel: UpComingModel?
    fileprivate weak var presenter: UpComingViewProtocol?
    func getData(index: Int) {
        currentPage = 1
        MAWebServirce.shareInstance.sendGETRequest(path: "https://api.themoviedb.org/3/movie/upcoming?api_key=437aa21c2934a238513bec5adfe05a4a&language=vi-VN&page=\(index)", params: nil,headers: nil, responseObjectClass:UpComingListModel()) { [weak self] success , response in
            
            if(success) {
                
                guard let data = response as? UpComingListModel else {
                    return
                }
                self?.upComingModel = UpComingModel()
                self?.upComingModel?.upComingModel = data
                self?.presenter?.loadDataSuccessed()
                
                
            }
            
        }
    }
    func attachView(view: UpComingViewProtocol) {
        self.presenter = view
    }
}
