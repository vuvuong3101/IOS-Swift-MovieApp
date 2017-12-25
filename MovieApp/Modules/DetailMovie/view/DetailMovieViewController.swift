//
//  DetailMovieViewController.swift
//  MovieApp
//
//  Created by ADMIN on 12/17/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import UIKit
import Cosmos
import Kingfisher
import YouTubePlayer
class DetailMovieViewController: UIViewController {
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.dismiss(animated: true)
    }
    @IBOutlet weak var collectionListVideo: UICollectionView!
    @IBOutlet weak var videoView: YouTubePlayerView!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var review: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var buttonViewTrailer: UIButton!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var titlemovie: UILabel!
    @IBOutlet weak var imagePoster: UIImageView!
    var detailPresenter: DetailMoviePresenter?
    var videoPresenter: VideoMoviePresenter?
    var modelSearch: SearchViewModel? 
    var detailData: DetailMovieViewModel?
    var videoData: [VideoMovieViewModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()
        self.configPresenter()
        self.configCollectionListVideo()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        print(modelSearch?.overView ?? "ko co review")    }
    override func viewWillAppear(_ animated: Bool) {
        self.setupView()
        
        
    }
    func configPresenter(){
        detailPresenter?.attachView(view: self)
        videoPresenter?.attachView(view: self)
    }
    func configView(){
        imagePoster.borderColor = UIColor.init(netHex: 0xf8f8f8)
        imagePoster.borderWidth = 1
        imagePoster.layer.cornerRadius = 5
        detailPresenter = DetailMoviePresenter()
        videoPresenter = VideoMoviePresenter()
        self.view.backgroundColor = UIColor.init(netHex: 0x151c25)
        buttonViewTrailer.addTarget(self, action: #selector(self.playVideoWith)
            , for: UIControlEvents.touchUpInside)
        
    }
    func configCollectionListVideo(){
        collectionListVideo.backgroundColor = UIColor.init(netHex: 0x151c25)
        collectionListVideo.delegate =  self
        collectionListVideo.dataSource = self
        collectionListVideo.register(UINib(nibName: "VideoInDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"VideoInDetailCollectionViewCell")
        collectionListVideo.isScrollEnabled = true
        collectionListVideo.showsVerticalScrollIndicator = false
        collectionListVideo.showsHorizontalScrollIndicator = true
        collectionListVideo.indicatorStyle = .white
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.sectionInset = UIEdgeInsetsMake(0,0,0,0)
        collectionLayout.minimumInteritemSpacing = 16
        collectionLayout.minimumLineSpacing = 9
        collectionListVideo.setCollectionViewLayout(collectionLayout, animated: false)
    }
    func setupView(){
        buttonViewTrailer.borderWidth = 1
        buttonViewTrailer.borderColor = UIColor.init(netHex: 0xedae1d)
        self.releaseDate.text = "Release: \(modelSearch?.relaseDate ?? "")"
        self.titlemovie.text = modelSearch?.title ?? ""
        self.viewRating.rating = Double((modelSearch?.voteAverage)!)/2
        let url2 = URL(string: "http://image.tmdb.org/t/p/w320\(modelSearch?.posterPath ?? "")")
        self.imagePoster.kf.setImage(with: url2)
        let id =  (modelSearch?.id)!
        self.detailPresenter?.getDataWith(idMovie: id)
        self.videoPresenter?.getData(idMovie: id)
        self.review.text = modelSearch?.overView
        let a = Double((modelSearch?.voteAverage)!)
        let b = round(a: a)
        self.voteCount.text = String(b)
    }
    
    func round(a:Double)->Double{
        let mu = pow(10.0,1.0)
        let r = Darwin.round(a*mu)/mu
        return r
    }
    @objc func playVideoWith(){
        
        print("play video")
    }
    
}


extension DetailMovieViewController: SearchSendDataProtocol, HomeProtocol{
    func sendDataWithModelHome(modelHome: MABaseModel) {
        
    }
    
    func sendDataWithModel(model: SearchViewModel) {
        self.modelSearch = model
    }
}

extension DetailMovieViewController: DetailMovieViewProtocol{
    func loadDataDetailComplete() {
        print("moreDetail",detailData?.runTime ?? "khong co data" )// loi data moredetail
    }
}

extension DetailMovieViewController: VideoMovieViewProtocol{
    func getVideoComplete() {
        
        guard (videoPresenter?.videoMovieList?.videoModels?.videoMovieListModel)!.isEmpty else{
            return
        }
        videoData =  (videoPresenter?.videoMovieList?.videoModels?.videoMovieListModel)!
        collectionListVideo.reloadData()
    }
}

extension DetailMovieViewController: UICollectionViewDelegate{
    
}

extension DetailMovieViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: "VideoInDetailCollectionViewCell", for: indexPath) as? VideoInDetailCollectionViewCell
        cell?.fillDataToCell(model: videoData[indexPath.row])
        cell?.cornerRadius = 10
        return cell!
    }
    
    
}

extension DetailMovieViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(sizeItemCollection())
        return sizeItemCollection()
    }
    
    func sizeItemCollection() -> CGSize{
        let bounds = UIScreen.main.bounds
        
        if bounds.width == 320.0 && videoData.count == 1 {return CGSize(width: 290, height: 150)}
        else if bounds.width == 375.0 && videoData.count == 1 {return CGSize(width: 340, height: 170)}
        else if bounds.width >=  414.0  && videoData.count == 1 {return CGSize(width: 390, height:250)}
        else if bounds.width == 320.0 && videoData.count > 1 {return CGSize(width: 240, height: 150)}
        else if bounds.width == 375.0 && videoData.count > 1 {return CGSize(width: 290, height: 170)}
        else if bounds.width >=  414.0  && videoData.count > 1 {return CGSize(width: 300, height: 250)}
        else{return CGSize(width: 300, height: 200)}
        
    }
    
    
}
