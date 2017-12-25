//
//  DetailMovieViewModel.swift
//  MovieApp
//
//  Created by ADMIN on 12/21/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import Foundation
class DetailMovieViewModel: MABaseModel{
    var genreList: [String: AnyObject]?
    var productionCompanies: [String: AnyObject]?
    var runTime: Int?
    var status: String?
    var homePage: String?
    var productionCountries: [String: AnyObject]?
    override func paserResponse(dic: NSDictionary) {
        self.genreList = dic["genres"] as? Dictionary
        self.productionCompanies = dic["production_companies"] as? [String: AnyObject]
        self.runTime = dic["runtime"] as? Int
        self.status = dic["status"] as? String
        self.homePage = dic["homepage"] as? String
        self.productionCountries = dic["production_countries"] as? [String: AnyObject]
    }
}

