//
//  NơPlayingPresenter.swift
//  MovieApp
//
//  Created by ADMIN on 12/17/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import Foundation
class TopRatePresenter: NowPlayingProtocolPresenter{
    
    
    var modelNowList: TopRateModel?
    
    var currentPage = 1
    var modelTopRate: TopRateModel?
    fileprivate weak var viewpresenter: TopRateProtocolForView?
    func attachView(view: TopRateProtocolForView) {
        self.viewpresenter = view
    }
    
    
    
    func getData(index: Int) {
        MAWebServirce.shareInstance.sendGETRequest(path: "https://api.themoviedb.org/3/movie/top_rated?api_key=437aa21c2934a238513bec5adfe05a4a&language=vi-VN&page=\(index)", params: nil,headers: nil, responseObjectClass: NowPlayingListModel()) { [weak self] success , response in
            
            if(success) {
                
                guard let data = response as? NowPlayingListModel else {
                    return
                }
                self?.modelTopRate = TopRateModel()
                self?.modelTopRate?.topRateModelList = data
                self?.viewpresenter?.loadDataSuccess()
                
                
            }
            
        }
        
        
    }
}
