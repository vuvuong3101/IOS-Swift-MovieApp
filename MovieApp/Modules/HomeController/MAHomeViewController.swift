//
//  MAHomeViewController.swift
//  MovieApp
//
//  Created by ADMIN on 12/14/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import FSPagerView
import SVProgressHUD
import Cosmos
import Kingfisher
import GradientLoadingBar
class MAHomeViewController: UIViewController {
    @IBOutlet weak var pageViewBanner: FSPagerView!
    fileprivate let imageNames = ["thumbail-poster","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","thumbail-poster","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","thumbail-poster","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg"]
    var images: [UIImage] = []
    @IBOutlet weak var pageControl: FSPageControl!
    @IBOutlet weak var buttonPopular: UIButton!
    @IBOutlet weak var buttonUpComing: UIButton!
    @IBOutlet weak var buttonTopRate: UIButton!
    @IBOutlet weak var heightPagerView: NSLayoutConstraint!
    @IBOutlet weak var scrollViewHome: UIScrollView!
    @IBOutlet weak var upComingCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var topRateCollection: UICollectionView!
    @IBOutlet weak var contentView: UIView!
    var loadMore: Bool = true
    var presenterTopRate: TopRatePresenter?
    var presenterPopular: PopularPresenter?
    var presneterUpComing: UpComingPresenter?
    var topRateDataList: [TopRateModelView] = []
    var popularDataList : [PopularViewModel] = []
    var upComingDataList:  [UpComingViewModel] = []
    var refreshControl: UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenterTopRate = TopRatePresenter()
        presenterPopular = PopularPresenter()
        presneterUpComing = UpComingPresenter()
        pageViewBanner.dataSource = self
        pageViewBanner.delegate = self
        GradientLoadingBar.shared.show()
        self.getData()
        self.configViewController()
        self.configPageViewer()
        self.configNowPlayingCollectionView()
        self.configPopularCollectionView()
        self.configUpComingCollectionView()
        self.configPresenter()
        self.actionMorePage()
        // Do any additional setup after loading the view.
    }
    func getData(){
        let nRate = arc4random_uniform(350) + 1
        let nUp = arc4random_uniform(10) + 1
        let nPo = arc4random_uniform(990) + 1
        
        presenterTopRate?.getData(index: Int(nRate))
        presenterPopular?.getData(index: Int(nPo))
        presneterUpComing?.getData(index : Int(nUp))
    }
    func actionMorePage(){
        buttonTopRate.addTarget(self, action: #selector(self.moreTopRate)
            , for: UIControlEvents.touchUpInside)
        buttonPopular.addTarget(self, action: #selector(self.morePopular)
            , for: UIControlEvents.touchUpInside)
        buttonUpComing.addTarget(self, action: #selector(self.moreUpComing)
            , for: UIControlEvents.touchUpInside)
    }
    @objc func moreTopRate(){
        let topRateVC = MATopRateViewController(nibName:"MATopRateViewController", bundle: nil)
        self.navigationController?.pushViewController(topRateVC, animated: true)
    }
    @objc func moreUpComing(){
        let upComingVC = MAUpComingViewController(nibName:"MAUpComingViewController", bundle: nil)
        self.navigationController?.pushViewController(upComingVC, animated: true)
    }
    @objc func morePopular(){
        let PoVC = MAPopularViewController(nibName:"MAPopularViewController", bundle: nil)
        self.navigationController?.pushViewController(PoVC, animated: true)
    }
    func configPresenter(){
        self.presenterTopRate?.attachView(view: self)
        self.presenterPopular?.attachView(view: self)
        self.presneterUpComing?.attachView(view: self)
    }
    
    func configNowPlayingCollectionView(){
        topRateCollection.backgroundColor = UIColor.init(netHex: 0x151c25)
        topRateCollection.delegate =  self
        topRateCollection.dataSource = self
        topRateCollection.register(UINib(nibName: "MATopRateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"MATopRateCollectionViewCell")
        topRateCollection.isScrollEnabled = true
        topRateCollection.showsVerticalScrollIndicator = false
        topRateCollection.showsHorizontalScrollIndicator = true
        topRateCollection.indicatorStyle = .white
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.sectionInset = UIEdgeInsetsMake(10,20,7,7)
        collectionLayout.minimumInteritemSpacing = 9
        collectionLayout.minimumLineSpacing = 9
        topRateCollection.setCollectionViewLayout(collectionLayout, animated: false)
        
    }
    
    
    func configPopularCollectionView(){
        popularCollectionView.backgroundColor = UIColor.init(netHex: 0x151c25)
        popularCollectionView.delegate =  self
        popularCollectionView.dataSource = self
        popularCollectionView.register(UINib(nibName: "MAPopularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"MAPopularCollectionViewCell")
        popularCollectionView.isScrollEnabled = true
        popularCollectionView.showsVerticalScrollIndicator = false
        popularCollectionView.showsHorizontalScrollIndicator = true
        popularCollectionView.indicatorStyle = .white
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.sectionInset = UIEdgeInsetsMake(10,20,7,7)
        collectionLayout.minimumInteritemSpacing = 9
        collectionLayout.minimumLineSpacing = 9
        popularCollectionView.setCollectionViewLayout(collectionLayout, animated: false)
    }
    
    func configUpComingCollectionView(){
        upComingCollectionView.delegate =  self
        upComingCollectionView.dataSource = self
        upComingCollectionView.backgroundColor = UIColor.init(netHex: 0x151c25)
        upComingCollectionView.register(UINib(nibName: "MAUpComingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"MAUpComingCollectionViewCell")
        upComingCollectionView.isScrollEnabled = true
        upComingCollectionView.showsVerticalScrollIndicator = false
        upComingCollectionView.showsHorizontalScrollIndicator = true
        upComingCollectionView.indicatorStyle = .white
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.sectionInset = UIEdgeInsetsMake(10,20,7,7)
        collectionLayout.minimumInteritemSpacing = 9
        collectionLayout.minimumLineSpacing = 9
        upComingCollectionView.setCollectionViewLayout(collectionLayout, animated: false)
    }
    
    private func configViewController(){
        self.view.backgroundColor = UIColor.init(netHex: 0x151c25)
        self.contentView.backgroundColor = UIColor.init(netHex: 0x19212d)
        self.scrollViewHome.isScrollEnabled = true
        self.scrollViewHome.alwaysBounceVertical = true
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        self.scrollViewHome.addSubview(refreshControl!)

    }
    @objc func refresh(sender:AnyObject){
        let nRate = arc4random_uniform(350) + 1
        let nUp = arc4random_uniform(10) + 1
        let nPo = arc4random_uniform(990) + 1
        
        presenterTopRate?.getData(index: Int(nRate))
        presenterPopular?.getData(index: Int(nPo))
        presneterUpComing?.getData(index : Int(nUp))    }
    
    func configPageViewer(){
        pageControl.currentPage = 0
        pageControl.setFillColor(UIColor.white, for: UIControlState.normal)
        pageControl.setFillColor(UIColor.init(netHex: 0xedae1d), for: UIControlState.normal)
        pageControl.numberOfPages = 5
        pageViewBanner.automaticSlidingInterval = 5.0
        heightPagerView.constant = heightPageView()
        pageViewBanner.currentIndex = 0
        pageViewBanner.transformer = FSPagerViewTransformer(type: .overlap)
        self.pageViewBanner.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        let transform = self.sizeScaleItem()
        self.pageViewBanner.itemSize = self.pageViewBanner.frame.size.applying(transform)
        
    }
    
    let bounds = UIScreen.main.bounds
    func heightPageView() -> CGFloat{
        if bounds.width == 320 {return CGFloat(200)}
        else if bounds.width == 375 {return CGFloat(220)}
        else if bounds.width >= 414 {return CGFloat(250)}
        else{return CGFloat(250)}
    }
    
    func sizeScaleItem() -> CGAffineTransform{
        if bounds.width == 320.0 {return CGAffineTransform(scaleX: 1.2, y: 0.9)}
        else if bounds.width == 375.0 {return CGAffineTransform(scaleX: 1.2, y: 0.9)}
        else if bounds.width >=  414.0 {return CGAffineTransform(scaleX: 1.2, y: 0.9)}
        else{return CGAffineTransform(scaleX: 1.2, y: 0.9)}
    }
    
}

//** extention PagerView deleagte **//
extension MAHomeViewController: FSPagerViewDelegate{
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        var index = 0
      
        if targetIndex < pageControl.numberOfPages{
            index = targetIndex
            
            pageControl.currentPage = index
        }else {
            index = targetIndex - pageControl.numberOfPages
            pageControl.currentPage = index
        }
        
    }
}
//**Protocol **//
extension MAHomeViewController: TopRateProtocolForView{
    func loadDataSuccess() {
        GradientLoadingBar.shared.hide()
        delayTimeRefresh()
        self.topRateDataList = (presenterTopRate?.modelTopRate?.topRateModelList?.nowPlayingListModel)!
//        self.getImage()
        self.topRateCollection.reloadData()
        
    }
    func delayTimeRefresh(){
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            self.refreshControl.endRefreshing()
        })
    }
}

extension MAHomeViewController: PopularProtocolForView{
    func loadDataComplete() {
        SVProgressHUD.dismiss(withDelay: 1)
        delayTimeRefresh()
        self.popularDataList = (presenterPopular?.popularModel?.popularModel?.popularListModel)!
        self.popularCollectionView.reloadData()
    }
}

extension MAHomeViewController: UpComingViewProtocol{
    func loadDataSuccessed() {
        SVProgressHUD.dismiss(withDelay: 1)
        delayTimeRefresh()
        self.upComingDataList = (presneterUpComing?.upComingModel?.upComingModel?.upComingListModel)!
        self.upComingCollectionView.reloadData()
    }
}



//** PAGE VIEWER **//
extension MAHomeViewController: FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
//        let url = URL(string: "http://image.tmdb.org/t/p/w320\(popularDataList[index].backdropPath ?? "")")
//        cell.imageView?.kf.setImage(with: url!)
        cell.imageView?.image = UIImage(named: imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.imageView?.cornerRadius = 5

        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    
    
}

//**CollectionViewHome **//
extension MAHomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.topRateCollection{
            return CGSize(width: 150, height: 240)
        }else if collectionView == self.popularCollectionView {
            return CGSize(width: 150, height: 240)
            
        }else{
            return CGSize(width: 150, height: 240)
            
        }
    }
}

extension MAHomeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.topRateCollection{
        }else if collectionView == self.popularCollectionView {
            
        }else{
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if collectionView == self.topRateCollection{
                if let cell = collectionView.cellForItem(at: indexPath) as? MATopRateCollectionViewCell {
                    cell.imageNowPlaying.transform = .init(scaleX: 0.85, y: 0.85)
                    
                    
                    
                }
            }else if collectionView == self.popularCollectionView {
                if let cell = collectionView.cellForItem(at: indexPath) as? MAPopularCollectionViewCell {
                    cell.imageNowPlaying.transform = .init(scaleX: 0.85, y: 0.85)
                    
                }
            }else{
                if let cell = collectionView.cellForItem(at: indexPath) as? MAUpComingCollectionViewCell {
                    cell.imageNowPlaying.transform = .init(scaleX: 0.85, y: 0.85)
                    
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if collectionView == self.topRateCollection{
                if let cell = collectionView.cellForItem(at: indexPath) as? MATopRateCollectionViewCell {
                    cell.imageNowPlaying.transform = .identity
                    cell.contentView.backgroundColor = .clear
                }
            }else if collectionView == self.popularCollectionView {
                if let cell = collectionView.cellForItem(at: indexPath) as? MAPopularCollectionViewCell {
                    cell.imageNowPlaying.transform = .identity
                    cell.contentView.backgroundColor = .clear
                }
            }else{
                if let cell = collectionView.cellForItem(at: indexPath) as? MAUpComingCollectionViewCell {
                    cell.imageNowPlaying.transform = .identity
                    cell.contentView.backgroundColor = .clear
                }
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.topRateCollection{
            
        }else if collectionView == self.popularCollectionView {
            if indexPath.row == imageNames.count/2 && !loadMore{
                loadMore = true
                SVProgressHUD.show()
                
                //loadmore
            }
        }else{
            if indexPath.row == imageNames.count/2 && !loadMore{
                loadMore = true
                SVProgressHUD.show()
                
                //loadmore
            }
            
        }
    }
    
    
}

extension MAHomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.topRateCollection{
            return topRateDataList.count 
        }else if collectionView == self.popularCollectionView {
            return popularDataList.count
        }else{
            return upComingDataList.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.topRateCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MATopRateCollectionViewCell", for: indexPath) as! MATopRateCollectionViewCell
            cell.fillDataToCell(model: topRateDataList[indexPath.row])
            return cell
        }else if collectionView == self.popularCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MAPopularCollectionViewCell", for: indexPath) as? MAPopularCollectionViewCell
            cell?.fillDataToCell(model: popularDataList[indexPath.row])
            return cell!
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MAUpComingCollectionViewCell", for: indexPath) as? MAUpComingCollectionViewCell
            cell?.fillDataToCell(model: upComingDataList[indexPath.row])
            return cell!
        }
    }
}


