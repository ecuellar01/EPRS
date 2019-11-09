//
//  SignUpViewController.swift
//  EPRS
//
//  Created by Matthias Bogarin on 11/6/19.
//  Copyright © 2019 Matthias Bogarin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    
    @IBOutlet var EmailTextField: UITextField!

    @IBOutlet var PasswordTextField: UITextField!
    
    @IBOutlet var RepeatPasswordTextField: UITextField!
    
    @IBOutlet var SignUpButton: UIButton!
    
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
        
        
        //hide the error label
        ErrorLabel.alpha = 0
        
        
        //Style the elements
        Utilities.styleTextField(EmailTextField)
        Utilities.styleTextField(PasswordTextField)
        Utilities.styleTextField(RepeatPasswordTextField)
        Utilities.styleFilledButton(SignUpButton)
        
        
    }

    
    
    func validateFields() -> String?{
        
        
        //Check that all fields are filled in.
        if EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            RepeatPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in all fields."
        }
        
        
        //Check if the password is secure.
        let cleanedPassword = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false{
            //password isnt secure enough.
            return "Please make sure your passwrd is at least 8 characters, contains a special character and a number."
        }
        //Check if the passwords are the same.
        if PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) != RepeatPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        {
            //Will return an error message if the passwords do not match.
            return "Please make sure the passwords are the same."
        }
        
        return nil
    }

    
    @IBAction func SignUpTapped(_ sender: Any) {
        
        //Validate fields.
        let error = validateFields()
        
        if error != nil{
            showError(error!)
        }
        else
        {
            
            //Create clean versions of the data.
            
            let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            // Create the user.
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
               if err != nil {
                    //There was an error creating the user.
                    self.showError("Error creating user")
               }
               else
               {
                    //User was created successfully
                   
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["email":email,"password":password,"uid": result!.user.uid]){(error) in
                    
                    if error != nil{
                        self.showError("Error saving user data")
                    }
                    
                    self.transitionToHome()
                    
                }
                
                
            
        
                    
                    
                }
            }
        }
        
    }
    
    //Transition to home screen
    func transitionToHome(){
        
        let homeViewControler = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as?
            HomeViewController
        
        self.view.window?.rootViewController = homeViewControler
        self.view.window?.makeKeyAndVisible()
        
    }
    func showError(_ message:String){
        
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }
    
}


