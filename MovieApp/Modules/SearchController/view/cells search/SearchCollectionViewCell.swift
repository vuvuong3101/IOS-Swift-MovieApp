//
//  SearchCollectionViewCell.swift
//  MovieApp
//
//  Created by ADMIN on 12/19/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import UIKit
import Cosmos
class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewRating: CosmosView!

    @IBOutlet weak var rateNowPlaying: UILabel!
    @IBOutlet weak var titleNowPlaying: UILabel!
    @IBOutlet weak var imageNowPlaying: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configCell()
    }
    func fillDataToCell(model: SearchViewModel){
        self.titleNowPlaying.text = model.title
        self.rateNowPlaying.text = "Release: \(model.relaseDate ?? "")"
        let url = URL(string: "http://image.tmdb.org/t/p/w320\(model.posterPath ?? "")")
        self.imageNowPlaying.kf.setImage(with: url)
        self.viewRating.rating = Double(model.voteAverage)/2
    }
    
    
    func configCell(){
        imageNowPlaying.layer.cornerRadius = 5
        imageNowPlaying.contentMode = .scaleToFill
        imageNowPlaying.clipsToBounds = true
        imageNowPlaying.layer.masksToBounds = true
    }
}
