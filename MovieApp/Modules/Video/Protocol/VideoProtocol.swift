//
//  VideoProtocol.swift
//  MovieApp
//
//  Created by ADMIN on 12/21/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import Foundation
protocol VideoMovieViewProtocol: class {
    func getVideoComplete()
}

protocol VideoMoviePresenterProtocol: class {
    var videoMovieList: VideoModel?{get set}
    func getData(idMovie: Int)
    func attachView(view: VideoMovieViewProtocol)
}
