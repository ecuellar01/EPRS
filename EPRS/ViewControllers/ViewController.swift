//
//  ViewController.swift
//  EPRS
//
//  Created by Matthias Bogarin on 11/4/19.
//  Copyright © 2019 Matthias Bogarin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var LoginWithEmailButton: UIButton!
    
    @IBOutlet var SignUpWithEmailButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpElements()
        
    }

    
    func setUpElements(){
        
        //Style the Elements
        Utilities.styleHollowButton(LoginWithEmailButton)
        Utilities.styleFilledButton(SignUpWithEmailButton)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Disposes of any resources that can be created.
    }

    @IBAction func LoginView(_ sender: Any) {
        //Performs Seque to loginViewController Page when Login Button is tapped.
        self.performSegue(withIdentifier:"LoginView", sender: self);
    }
    
    @IBAction func SignupView(_ sender: Any) {
         //Performs Seque to SignUpViewController Page when Sign up button is tapped.
        
        self.performSegue(withIdentifier: "SignupView", sender: self);
    }
    
    
    
}

