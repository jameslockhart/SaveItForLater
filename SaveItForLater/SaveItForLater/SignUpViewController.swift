//
//  SignUpViewController.swift
//  SaveItForLater
//
//  Created by Jamie Lockhart on 2017-01-28.
//  Copyright © 2017 iLockhart. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD

class SignUpViewController: UIViewController {
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //It will show the status bar again after dismiss
        UIApplication.shared.isStatusBarHidden = false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func signUp(_ sender: Any) {
        let emailStr = email.text
        let passwordStr = password.text
        
        let loadingNotification = MBProgressHUD.showAdded(to:self.view, animated: true)
        loadingNotification.mode = .indeterminate
        loadingNotification.label.text = "Signing up..."
        
        FIRAuth.auth()?.createUser(withEmail: emailStr!, password: passwordStr!) { (user, error) in
            loadingNotification.hide(animated: true)
            
            if (error != nil) {
                let alertController = UIAlertController(title: "Signup issue", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigation") as! UINavigationController
                self.present(nav, animated: true, completion: nil)
            }
        }
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
