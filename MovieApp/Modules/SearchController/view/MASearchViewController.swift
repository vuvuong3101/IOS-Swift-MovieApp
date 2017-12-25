//
//  MAProfileViewController.swift
//  MovieApp
//
//  Created by ADMIN on 12/14/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import UIKit
import SVProgressHUD
import JTMaterialTransition
import NVActivityIndicatorView
class MASearchViewController: UIViewController {
    @IBOutlet weak var TralingRightOfViewSearch: NSLayoutConstraint!
    @IBOutlet weak var TralingRightOfCancleButton: NSLayoutConstraint!
    @IBOutlet weak var contantWidthCancel: NSLayoutConstraint!
    var isExpand: Bool = true
    var isLoadMore : Bool = false
    var delegation :SearchSendDataProtocol?
    var transition: JTMaterialTransition?
    var activityIndicator : NVActivityIndicatorView?
    var button : UIButton?
    weak var presentControllerButton: SearchCollectionViewCell?
    @IBOutlet weak var buttonDeleteTextTF: UIButton!
    @IBOutlet weak var imageNoData: UIImageView!
    @IBOutlet weak var searchCollection: UICollectionView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var TFSearch: UITextField!
    @IBOutlet weak var viewSearchView: UIView!
    var refreshControl: UIRefreshControl!
    var presenter: SearchPresenter?
    var searchResults: [SearchViewModel] = []
    var allResults: [SearchViewModel] = []
    var textFormat: TextFormat?
    var pageRS = 1
    var listYears = ["2000","2001", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017"]
    //** loadmore data **//
    func loadMoreData(){
        isLoadMore = true
        let allpage = presenter?.searchViewModel?.searchModel?.totalPage!
        if pageRS < allpage!{
            pageRS += 1
        }
        presenter?.pageResult = pageRS
        presenter?.searchWithText()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        refreshControl = UIRefreshControl()
        textFormat = TextFormat()
        presenter = SearchPresenter()
        configView()
        configPresenter()
        configSearchCollectionView()
        ramdomSearch()
        checkButtonHidden()

    }
    @objc func DeleteTextTF(){
        TFSearch.text = ""
    }
    
    func checkButtonHidden(){
        if TFSearch.text == "" {
            buttonDeleteTextTF.isHidden = true
        }else{
            buttonDeleteTextTF.isHidden = false
        }
        
        buttonDeleteTextTF.addTarget(self, action: #selector(self.DeleteTextTF), for: UIControlEvents.touchUpInside)
    }
    //** ramdom search a key world if TFsearch empty**//
    func ramdomSearch(){
        let keys = ["A","hero","war","love","race","galaxy","action","kungfu", "discovery" ,"B", "C", "D", "E", "F" , "G" , "H", "J", "K" , "L", "Q" , "T", "V", "R", "I", "O", "P", "Y", "U", "X", "Z", "M", "N" ,"JU" ,"TR" ,"Ru", "lu"]
        let n = Int(arc4random_uniform(UInt32(keys.count)))
        presenter?.textSearch = keys[n]
        presenter?.searchWithText()
    }
    //** auto complete textSeacrh to result data **//
    @IBAction func checkBeginSearch(_ sender: Any) {
        contantWidthCancel.constant = 42
        TralingRightOfViewSearch.constant = 6
        TralingRightOfCancleButton.constant = 16
    }
    
    @IBAction func actionCancle(_ sender: Any) {
        contantWidthCancel.constant = 0
        TralingRightOfCancleButton.constant = 0
        DeleteTextTF()
        dismissKeyboard()
        TralingRightOfViewSearch.constant = 16
        checkButtonHidden()

    }
    
    
    @IBAction func textFieldDidChange(_ sender: Any) {
        let textSearch = textFormat?.filterTextToEN(text: TFSearch.text!)
        self.presenter?.textSearch = textSearch
        checkButtonHidden()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.presenter?.searchWithText()
            
        })
        if (TFSearch.text?.isEmpty)!{
            ramdomSearch()
        }else{
            
        }
    }
    //** format text input ->>  **//
    func replaceText(of: String, with: String)-> String{
        let textSearch = TFSearch.text
        let textDidFormat = textSearch?.replacingOccurrences(of: of, with: with) ?? " "
        return textDidFormat
    }
    
    
    
    func SizeItemCollection() -> CGSize{
        let bounds = UIScreen.main.bounds
        if bounds.width == 320 {return CGSize(width: 130, height: 200 )}
        else if bounds.width == 375 {return CGSize(width: 160, height: 220)}
        else if bounds.width >= 414 {return CGSize(width:185, height: 260)}
        else{return CGSize(width:180, height: 260)}
    }
    
    func configSearchCollectionView(){
        searchCollection.backgroundColor = UIColor.init(netHex: 0x151c25)
        searchCollection.delegate =  self
        searchCollection.dataSource = self
        searchCollection.register(UINib(nibName: "SearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"SearchCollectionViewCell")
        searchCollection.register(UINib(nibName: "FooterSearchCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "FooterSearchCell")
        searchCollection.register(UINib(nibName: "HeaderSearchCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "HeaderSearchCell")
        searchCollection.isScrollEnabled = true
        searchCollection.showsVerticalScrollIndicator = true
        searchCollection.showsHorizontalScrollIndicator = false
        searchCollection.indicatorStyle = .black
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        collectionLayout.itemSize = SizeItemCollection()
        collectionLayout.sectionInset = UIEdgeInsetsMake(10, 16, 10, 16)
        collectionLayout.minimumInteritemSpacing = 4
        collectionLayout.minimumLineSpacing = 16
        searchCollection.setCollectionViewLayout(collectionLayout, animated: true)
    }
    
    func configView(){
        self.view.backgroundColor = UIColor.init(netHex: 0x151c25)
        TFSearch.attributedPlaceholder = NSAttributedString(string: "Search",
                                                            attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        
        viewSearchView.layer.cornerRadius = viewSearchView.bounds.height/2
        TFSearch.cornerRadius = TFSearch.bounds.height/2
        buttonDeleteTextTF.isHidden = true
         TralingRightOfViewSearch.constant = 16
    }
        
    
    
    func configPresenter(){
        self.presenter?.attachView(view: self)
    }
}

extension MASearchViewController: SearchViewProtocol{
    func getDataComplete() {
        searchResults = (presenter?.searchViewModel?.searchModel?.searchListModel)!
        
        if !isLoadMore {
            allResults = searchResults
            searchCollection.reloadData()
            isLoadMore = false
            
        }else{
            for data in searchResults{
                allResults.append(data)
            }
            searchCollection.reloadData()
            isLoadMore = false
        }
        
    }
}

extension MASearchViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if allResults.count > 0 {
            self.searchCollection.isHidden = false
            self.imageNoData.isHidden = true
        }else{
            self.searchCollection.isHidden = true
            self.imageNoData.isHidden = false
        }
        return allResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell
        cell?.fillDataToCell(model: allResults[indexPath.row])
        self.transition = JTMaterialTransition(animatedView: cell!)

        return cell!
    }
    
    
}
extension MASearchViewController: UICollectionViewDelegate, UIGestureRecognizerDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegation?.sendDataWithModel(model: allResults[indexPath.row])
        
        let vc = DetailMovieViewController(nibName: "DetailMovieViewController", bundle: nil)
        let data = allResults[indexPath.row]
        
        vc.modelSearch = data
        vc.modalPresentationStyle = .overFullScreen
        vc.transitioningDelegate = self.transition
//        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterSearchCell", for: indexPath)
        button = UIButton(frame: CGRect(x: footer.bounds.width/2 - 50, y: 35, width: 100, height: 30))
        button?.backgroundColor = UIColor.clear
        button?.layer.borderWidth = 1
        button?.layer.borderColor = UIColor.white.cgColor
        button?.layer.cornerRadius = 5
        button?.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button?.tintColor = UIColor.brown
        button?.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        self.button?.setTitle("show more", for: .normal)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        button?.isUserInteractionEnabled = true
        tapRecognizer.delegate = self
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        button?.addGestureRecognizer(tapRecognizer)
        footer.addSubview(button!)

        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: (footer.bounds.width)/2 - 15 , y: 0 , width: 30, height: 25), type: .ballPulseSync, color: UIColor.white, padding: 0)
        footer.addSubview(activityIndicator!)

        return footer
    }
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer){
        activityIndicator?.startAnimating()
        DispatchQueue.main.async {
            self.button?.setTitle("", for: .normal)
        }
         DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.loadMoreData()
         })
        delayTimeRefresh()
    }
    
    func delayTimeRefresh(){
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            self.button?.setTitle("Show more", for: .normal)
            self.activityIndicator?.stopAnimating()
        })
    }
}

extension MASearchViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 200, height: 70)
    }
}





