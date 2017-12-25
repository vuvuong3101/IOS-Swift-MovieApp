//
//  RegisterViewController.swift
//  MovieApp
//
//  Created by ADMIN on 12/25/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var contantNTRepeatPass: NSLayoutConstraint!
    @IBOutlet weak var contantNTPassword: NSLayoutConstraint!
    @IBOutlet weak var contantNTEmail: NSLayoutConstraint!
    @IBOutlet weak var contantNTUsername: NSLayoutConstraint!
    @IBOutlet weak var NoticeRepeatPassword: UILabel!
    @IBOutlet weak var NoticePassword: UILabel!
    @IBOutlet weak var NoticeEmail: UILabel!
    @IBOutlet weak var NoticeUsername: UILabel!
    @IBOutlet weak var TFrepeatpassword: UITextField!
    @IBOutlet weak var TFpassword: UITextField!
    @IBOutlet weak var TFemail: UITextField!
    @IBOutlet weak var TFusername: UITextField!
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()
        // Do any additional setup after loading the view.
    }

    func configView(){
        hideKeyboardWhenTappedAround()
         self.view.setGradientBackground(startColor: UIColor.init(netHex: 0x09203f), endColor: UIColor.init(netHex: 0x537895))
        contantNTUsername.constant = 0.0
        contantNTEmail.constant = 0.0
        contantNTPassword.constant = 0.0
        contantNTRepeatPass.constant = 0.0
        TFusername.updateConstraints()
        TFemail.updateConstraints()
        TFpassword.updateConstraints()
        TFrepeatpassword.updateConstraints()
        view.layoutIfNeeded()
        view.updateConstraintsIfNeeded()
    }
    func checkInputOfUser(){
        if (TFusername.text?.isEmpty)! {
            NoticeUsername.text = "You don't input your username"
        }
    }
    
}
