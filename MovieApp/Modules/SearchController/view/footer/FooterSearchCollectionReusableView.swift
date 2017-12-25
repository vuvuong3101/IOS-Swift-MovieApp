//
//  FooterSearchCollectionReusableView.swift
//  MovieApp
//
//  Created by ADMIN on 12/22/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import UIKit

class FooterSearchCollectionReusableView: UICollectionReusableView {
    var presenter: SearchPresenter?
    @IBOutlet weak var buttonShow: UIButton!
    var delegation: MASearchViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configView()
    }
    
    func configView(){
        delegation = MASearchViewController()
        presenter = SearchPresenter()
        
    }
    
    
}

