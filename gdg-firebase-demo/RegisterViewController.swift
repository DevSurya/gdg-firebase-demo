//
//  RegisterViewController.swift
//  gdg-firebase-demo
//
//  Created by Surya Narayan Barik on 9/9/17.
//  Copyright © 2017 Surya. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailIdTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func registerBtnPressed(_ sender: UIButton) {
        if nameTF.text != nil && emailIdTF.text != nil && passwordTF.text != nil {
            
            FIRAuth.auth()!.createUser(withEmail: emailIdTF.text!, password: passwordTF.text!) { user, error in
                if error == nil {
                    guard let uid = user?.uid else{
                        
                        let alert = UIAlertController(title: "Eroor ",
                                                      message: "Something going wrong , Please try again !!",
                                                      preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Ok",
                                                     style: .default)
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                    
                    let userRef = FIRDatabase.database().reference()
                    let userInfo = ["userName": self.nameTF.text ,"email":self.emailIdTF.text]
                    
                    userRef.child("user").child(uid).setValue(["userName": self.nameTF.text])
                    
                    userRef.child("user").child(uid).updateChildValues(userInfo as Any as! [AnyHashable : Any], withCompletionBlock: { (error, ref) in

                        let alert = UIAlertController(title: "Wooooh ... !! ",
                                                      message: "Sucessfully Register",
                                                      preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Ok",
                                                     style: .default){ (action: UIAlertAction!) in
                           _ = self.navigationController?.popViewController(animated: true)

                        }
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                    })
                } else {
                    let alert = UIAlertController(title: "Eroor ",
                                                  message: "Please enter a valid details",
                                                  preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok",
                                                 style: .default)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
    }
}

}
