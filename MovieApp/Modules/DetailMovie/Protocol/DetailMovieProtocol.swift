//
//  DetailMovieProtocol.swift
//  MovieApp
//
//  Created by ADMIN on 12/21/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import Foundation
protocol DetailMovieViewProtocol: class {
    func loadDataDetailComplete()
}

protocol DetailMoviePresenterProtocol:  class {
    var detailModel: DetailMovieViewModel?{get set}
    func getDataWith(idMovie: Int)
    func attachView(view: DetailMovieViewProtocol)
}


