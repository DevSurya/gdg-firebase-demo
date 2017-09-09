//
//  HomeViewController.swift
//  gdg-firebase-demo
//
//  Created by Surya Narayan Barik on 9/9/17.
//  Copyright © 2017 Surya. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    @IBOutlet weak var emailIdTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customizeBtn(logInBtn)
        customizeBtn(registerBtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customizeBtn(_ btn : UIButton) {
        btn.layer.cornerRadius = 5.0
        btn.clipsToBounds = true
    }
    
    @IBAction func logInBtnPressed(_ sender: UIButton) {
        if self.emailIdTF.text != nil && self.passwordTF.text != nil {
            FIRAuth.auth()!.signIn(withEmail: self.emailIdTF.text!, password: self.passwordTF.text!, completion: { (user, error) in
                if user != nil {
                    print("Log in sucessfully")
                    let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                    self.navigationController?.pushViewController(welcomeVC, animated: true)
                }else{
                    
                    let alert = UIAlertController(title: "Eroor ",
                                                  message: "Please enter a valid credential",
                                                  preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok",
                                                 style: .default)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    
                }
            })
            

        }
        
    }
}
