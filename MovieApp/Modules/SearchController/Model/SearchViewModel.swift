//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by ADMIN on 12/19/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import Foundation
class SearchViewModel: MABaseModel{
    var id: Int!
    var voteAverage: Float!
    var voteAvarageString : String?
    var posterPath: String?
    var title: String?
    var originTitle: String?
    var overView: String?
    var relaseDate: String?
    var backdropPath: String?
    
    override func paserResponse(dic: NSDictionary) {
        id = dic.value(forKey: "id") as! Int
        voteAverage =  (dic.value(forKey: "vote_average") as! Float)
        voteAvarageString =  dic.value(forKey: "vote_average") as? String
        posterPath = dic.value(forKey: "poster_path") as? String
        title = dic.value(forKey: "title") as? String
        originTitle =  dic.value(forKey: "original_title") as? String
        overView = dic.value(forKey: "overview") as? String
        relaseDate = dic.value(forKey: "release_date") as? String
        backdropPath = dic.value(forKey: "backdrop_path") as? String
    }
}

class SearchListModel: MABaseModel{
    var searchListModel : [SearchViewModel]?
    var page: Int?
    var totalPage: Int?
    
    override func paserResponse(dic: NSDictionary) {
        page = dic.value(forKey: "page") as? Int
        totalPage = dic.value(forKey: "total_pages") as? Int
        guard let  datas = dic.value(forKey: "results") as? [NSDictionary] else {
            return
        }
        searchListModel = []
        for data in datas{
            let model = SearchViewModel()
            model.paserResponse(dic: data)
            searchListModel?.append(model)
        }
    }
}
