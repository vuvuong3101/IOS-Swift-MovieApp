//
//  TabbarViewController.swift
//  MovieApp
//
//  Created by ADMIN on 12/14/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import UIKit

class MATabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configTabbar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func configTabbar(){
        let homeVC = MAHomeViewController(nibName: "MAHomeViewController", bundle: nil)
        homeVC.tabBarItem.image = UIImage(named: "home")
        homeVC.title = "Home"
        
        let searchVC = MASearchViewController(nibName: "MASearchViewController", bundle: nil)
        searchVC.tabBarItem.image = UIImage(named: "binocular")
        searchVC.title = "Search"
        
        let favoriteVC = MAFavoriteViewController(nibName: "MAFavoriteViewController", bundle: nil)
        favoriteVC.tabBarItem.image = UIImage(named: "favorite")
        favoriteVC.title = "Favorite"
        
        let profileVC = MAProfileViewController(nibName: "MAProfileViewController", bundle: nil)
        profileVC.tabBarItem.image = UIImage(named: "profile")
        profileVC.title = "Profile"
        
        if let controllers = NSArray.init(objects: homeVC,searchVC, favoriteVC,profileVC) as? [UIViewController] {
            self.viewControllers = controllers

        }
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.lightGray], for: UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.init(netHex: 0xf8f8f8)], for: UIControlState.selected)
//        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.init(netHex: 0x151c25)
        
    }
    
    
    
}


