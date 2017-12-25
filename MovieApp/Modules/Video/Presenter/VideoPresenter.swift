//
//  VideoPresenter.swift
//  MovieApp
//
//  Created by ADMIN on 12/21/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import Foundation

class VideoMoviePresenter: VideoMoviePresenterProtocol{
    var videoMovieList: VideoModel?
    
    fileprivate weak var presenter: VideoMovieViewProtocol?
    func getData(idMovie: Int) {
        MAWebServirce.shareInstance.sendGETRequest(path: "https://api.themoviedb.org/3/movie/\(idMovie)/videos?api_key=437aa21c2934a238513bec5adfe05a4a&language=en-US", params: nil,headers: nil, responseObjectClass: VideoMovieListModel()) { [weak self] success , response in
            
            if(success) {
                guard let data = response as? VideoMovieListModel else {
                    return
                }
                self?.videoMovieList = VideoModel()
                self?.videoMovieList?.videoModels = data
                self?.presenter?.getVideoComplete()
                
                
            }
            
        }
    }
    
    func attachView(view: VideoMovieViewProtocol) {
        self.presenter = view
    }
}
