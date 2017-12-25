//
//  UpComingViewModel.swift
//  MovieApp
//
//  Created by ADMIN on 12/17/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import Foundation
class UpComingViewModel: MABaseModel{
    var id: String?
    var voteAverage: Int?
    var posterPath: String?
    var title: String?
    var originTitle: String?
    var overView: String?
    var relaseDate: String?
    var backdropPath: String?
    
    override func paserResponse(dic: NSDictionary) {
        id = dic.value(forKey: "id") as? String
        voteAverage =  dic.value(forKey: "vote_average") as? Int
        posterPath = dic.value(forKey: "poster_path") as? String
        title = dic.value(forKey: "title") as? String
        originTitle =  dic.value(forKey: "original_title") as? String
        overView = dic.value(forKey: "overview") as? String
        relaseDate = dic.value(forKey: "release_date") as? String
        backdropPath = dic.value(forKey: "backdrop_path") as? String
    }
}

class UpComingListModel: MABaseModel{
    var upComingListModel : [UpComingViewModel]?
    var page: Int?
    var totalPage: Int?
    override func paserResponse(dic: NSDictionary) {
        page = dic.value(forKey: "page") as? Int
        totalPage = dic.value(forKey: "total_pages") as? Int
        guard let  datas = dic.value(forKey: "results") as? [NSDictionary] else {
            return
        }
        upComingListModel = []
        for data in datas{
            let model = UpComingViewModel()
            model.paserResponse(dic: data)
            upComingListModel?.append(model)
        }
    }
}
