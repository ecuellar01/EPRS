//
//  LoginViewController.swift
//  EPRS
//
//  Created by Matthias Bogarin on 11/6/19.
//  Copyright © 2019 Matthias Bogarin. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet var EmailTextField: UITextField!
    
    @IBOutlet var PasswordTextField: UITextField!
    
    @IBOutlet var LoginButton: UIButton!
    
    @IBOutlet var ErrorLabel: UILabel!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    
    @IBAction func BackButtonTapped(_ sender: Any) {
        
        self.performSegue(withIdentifier:"ViewController", sender: self);
    }
    
    func setUpElements(){
        
        
        //Hide the error label
        ErrorLabel.alpha = 0;
        
        //Style the elements
        Utilities.styleTextField(EmailTextField)
        Utilities.styleTextField(PasswordTextField)
        Utilities.styleFilledButton(LoginButton)
        
        
    }

    
    
    func validateFields() -> String?{
        
        //Check that all fields are filled in.
        if EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
        
            return "Please fill in all fields."
            
        }
        
        return nil
    }
    
     
    @IBAction func LoginTapped(_ sender: Any) {
        
        //Validate Text Fields
        let error = validateFields()
        
         //Create clean versions of the data.
         
         let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
         
         let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        //Signing in the user
        
        if error != nil{
            showError(error!)
        }
        else
        {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if error != nil
                {
                    //Couldnt sign in
                    self.ErrorLabel.text = error!.localizedDescription
                    self.ErrorLabel.alpha = 1
                }
                else
                {
                    let homeViewControler = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as?
                               HomeViewController
                           
                           self.view.window?.rootViewController = homeViewControler
                           self.view.window?.makeKeyAndVisible()
                    
                    
                }
            }
        }
    }
    
    func showError(_ message:String){
        
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }
}
