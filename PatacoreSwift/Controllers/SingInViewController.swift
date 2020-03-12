//
//  SingInViewController.swift
//  PatacoreSwift
//
//  Created by Johana on 2/8/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import UIKit
import Firebase

class SingInViewController: UIViewController {

    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func SingInBtn(_sender :  UIButton) {
        
         if let email = self.userNameTextField.text, let password = self.passTextField.text {
                // [START headless_email_auth]
                Auth.auth().signIn(withEmail: email+"@patacore.com", password: password) { (user, error) in
                    // [START_EXCLUDE]

                    if let error = error {
                        //print(error.localizedDescription)
                        //show alert
                        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                        self.present(alert, animated: true)
                        return
                    }
                    //self.navigationController!.popViewController(animated: true)
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let tabBarViewController = storyboard.instantiateViewController (withIdentifier: "myTabBar") as! TabBarViewController
                    tabBarViewController.modalPresentationStyle = .fullScreen
                    self.present(tabBarViewController, animated: true, completion: nil)
                    // [END_EXCLUDE]
                }
                // [END headless_email_auth]
            } else {
               print("email/password can't be empty")
               //show alert
            }
         
        
          
    }
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
