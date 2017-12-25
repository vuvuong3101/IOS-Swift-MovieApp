//
//  MAPopularViewController.swift
//  MovieApp
//
//  Created by ADMIN on 12/20/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import UIKit

class MAPopularViewController: UIViewController {
    var presenter: PopularPresenter?
    var datas: [PopularViewModel] = []
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()
        self.configPresenter()
        configPopularCollectionView()
        presenter?.getData(index: 1)
    }
  
    func configView(){
        self.presenter = PopularPresenter()
        self.view.backgroundColor = PRIMARY_COLOR
    }
    func configPresenter(){
        self.presenter?.attachView(view: self)
    }
    func configPopularCollectionView(){
        popularCollectionView.backgroundColor = UIColor.init(netHex: 0x151c25)
        popularCollectionView.delegate =  self
        popularCollectionView.dataSource = self
        popularCollectionView.register(UINib(nibName: "MAPopularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"MAPopularCollectionViewCell")
        popularCollectionView.isScrollEnabled = true
        popularCollectionView.showsVerticalScrollIndicator = true
        popularCollectionView.showsHorizontalScrollIndicator = false
        popularCollectionView.indicatorStyle = .white
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        collectionLayout.sectionInset = UIEdgeInsetsMake(9,9,9,9)
        collectionLayout.minimumInteritemSpacing = 9
        collectionLayout.minimumLineSpacing = 9
        popularCollectionView.setCollectionViewLayout(collectionLayout, animated: false)
    }
    
   
}
extension MAPopularViewController: PopularProtocolForView{
    func loadDataComplete() {
        datas = (presenter?.popularModel?.popularModel?.popularListModel)!
        popularCollectionView.reloadData()
    }
    
    
}
extension MAPopularViewController: UICollectionViewDelegate{
    
}
extension MAPopularViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MAPopularCollectionViewCell", for: indexPath) as? MAPopularCollectionViewCell
        cell?.fillDataToCell(model: datas[indexPath.row])
        return cell!
    }
    
    
}



extension MAPopularViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeItemCollection()
    }
    func sizeItemCollection() -> CGSize{
        let bounds = UIScreen.main.bounds
        
        if bounds.width == 320.0 {return CGSize(width: 130, height: 150)}
        else if bounds.width == 375.0  {return CGSize(width: 150, height: 170)}
        else if bounds.width >=  414.0  {return CGSize(width: 180, height:250)}

        else{return CGSize(width:170, height: 200)}
        
    }
    
}


