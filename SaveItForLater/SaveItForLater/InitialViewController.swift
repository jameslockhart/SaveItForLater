//
//  InitialViewController.swift
//  SaveItForLater
//
//  Created by Jamie Lockhart on 2017-01-29.
//  Copyright © 2017 iLockhart. All rights reserved.
//

import UIKit
import Firebase

class InitialViewController: UIViewController {
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

        // Check for FirAuth and if we have something then log in
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                // show main screen
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigation") as! UINavigationController
                self.present(nav, animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
