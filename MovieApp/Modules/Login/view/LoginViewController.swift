//
//  LoginViewController.swift
//  MovieApp
//
//  Created by ADMIN on 12/24/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import UIKit
import JTMaterialTransition

class LoginViewController: UIViewController {

    @IBOutlet weak var buttonREGISTER: UIButton!
    @IBOutlet weak var buttonSIGNIN: UIButton!
    @IBOutlet weak var TFPassword: UITextField!
    @IBOutlet weak var TFUsername: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        congfigView()
        // Do any additional setup after loading the view.
    }

    func congfigView(){
    hideKeyboardWhenTappedAround()
      self.view.setGradientBackground(startColor: UIColor.init(netHex: 0x09203f), endColor: UIColor.init(netHex: 0x537895))
        buttonSIGNIN.addTarget(self, action: #selector(self.actionSignIn), for: UIControlEvents.touchUpInside)
        buttonREGISTER.addTarget(self, action: #selector(self.actionRegister), for: UIControlEvents.touchUpInside)
    
    }
    
    @objc func actionSignIn(){
        let mainVC = MATabbarViewController(nibName:"MATabbarViewController", bundle: nil)
        
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
    @objc func actionRegister(){
        let registerVC = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        self.navigationController?.present(registerVC, animated: true, completion: nil)
    
    }

}
