//
//  MAUpComingViewController.swift
//  MovieApp
//
//  Created by ADMIN on 12/20/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import UIKit

class MAUpComingViewController: UIViewController {
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func configView(){
        self.view.backgroundColor = PRIMARY_COLOR
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
