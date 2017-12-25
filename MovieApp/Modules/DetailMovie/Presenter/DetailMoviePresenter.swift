//
//  DetailMoviePresenter.swift
//  MovieApp
//
//  Created by ADMIN on 12/21/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import Foundation
import Alamofire
class DetailMoviePresenter: DetailMoviePresenterProtocol{
    var detailModel: DetailMovieViewModel?
    fileprivate weak var presenter: DetailMovieViewProtocol?
    func getDataWith(idMovie: Int) {
        Alamofire.request("https://api.themoviedb.org/3/movie/\(idMovie)/videos?api_key=437aa21c2934a238513bec5adfe05a4a&language=vi-VN").responseJSON { (response) in
            if let data = response.result.value as? NSDictionary {
                self.detailModel?.paserResponse(dic: data)
                self.presenter?.loadDataDetailComplete()
            }
        }
    }
    
    func attachView(view: DetailMovieViewProtocol) {
        self.presenter = view
    }
    
}

