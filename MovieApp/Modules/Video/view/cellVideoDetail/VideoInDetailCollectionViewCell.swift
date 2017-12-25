//
//  VideoInDetailCollectionViewCell.swift
//  MovieApp
//
//  Created by ADMIN on 12/25/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import UIKit
import YouTubePlayer
class VideoInDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageEmpty: UIImageView!
    @IBOutlet weak var videoview: YouTubePlayerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configCell()
    }
    func configCell(){
        videoview.layer.cornerRadius = 10
    }
    func fillDataToCell(model: VideoMovieViewModel){
        if !(model.key!.isEmpty) {
            let url = URL(string: "https://www.youtube.com/watch?v=\(model.key ?? "")")
            self.videoview.loadVideoURL(url!)

        }else{
            imageEmpty.image = UIImage(named: "1")

        }
       
    }
    
}
