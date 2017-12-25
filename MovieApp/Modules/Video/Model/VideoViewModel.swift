//
//  VideoViewModel.swift
//  MovieApp
//
//  Created by ADMIN on 12/21/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import Foundation

class VideoMovieViewModel: MABaseModel{
    var key: String?
    var name : String?
    var site: String?
    var size: Int?
    var type: String?
    override func paserResponse(dic: NSDictionary) {
        key =  dic["key"] as? String
        name = dic["name"]  as? String
        site = dic["site"] as? String
        size  =  dic["size"] as? Int
        type =  dic["type"] as? String
    }
}

class VideoMovieListModel: MABaseModel{
    var videoMovieListModel : [VideoMovieViewModel]?
    var page: Int?
    var totalPage: Int?
    override func paserResponse(dic: NSDictionary) {
        page = dic.value(forKey: "page") as? Int
        totalPage = dic.value(forKey: "total_pages") as? Int
        guard let  datas = dic.value(forKey: "results") as? [NSDictionary] else {
            return
        }
        videoMovieListModel = []
        for data in datas{
            let model = VideoMovieViewModel()
            model.paserResponse(dic: data)
            videoMovieListModel?.append(model)
        }
    }
}
