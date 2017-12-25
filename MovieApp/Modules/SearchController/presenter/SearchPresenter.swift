//
//  SearchPresenter.swift
//  MovieApp
//
//  Created by ADMIN on 12/19/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import Foundation
import SVProgressHUD
import GradientLoadingBar
class SearchPresenter: SearchPresenterProtocol{
    var isLoadMore: Bool = false
    var textSearch: String?
    var searchViewModel: SearchModel?
    var pageResult: Int?
    fileprivate weak var presenter: SearchViewProtocol?
    func searchWithText(){
        GradientLoadingBar.shared.show()
        MAWebServirce.shareInstance.sendGETRequest(path: "https://api.themoviedb.org/3/search/movie?api_key=437aa21c2934a238513bec5adfe05a4a&language=en-US&query=\(textSearch ?? "")&page=\(pageResult ?? 1)&include_adult=false", params: nil, headers: nil, responseObjectClass:SearchListModel()) { [weak self] success , response in
            
            if(success) {
                GradientLoadingBar.shared.hide()
                guard let data = response as? SearchListModel else {
                    return
                }
                self?.searchViewModel = SearchModel()
                self?.searchViewModel?.searchModel = data
                self?.presenter?.getDataComplete()
                
                
            }else{
                
            }
        }
    }
    
    func attachView(view: SearchViewProtocol) {
        self.presenter = view
    }
    
    
}
