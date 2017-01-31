//
//  SavesTableViewController.swift
//  SaveItForLater
//
//  Created by Jamie Lockhart on 2017-01-20.
//  Copyright © 2017 iLockhart. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD

class SavesTableViewController: UITableViewController, SaveItDataListDelegate {
    var saveItDataList: SaveItDataList?
    var loadingNotification: MBProgressHUD?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleImage = UIImage(named: "DiscFillTitle")
        self.navigationItem.titleView = UIImageView.init(image: titleImage)
        
        // log out if we lose user object
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user == nil {
                // show main screen
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        }
        
        loadingNotification = MBProgressHUD.showAdded(to:self.view, animated: true)
        loadingNotification!.mode = .indeterminate
        loadingNotification!.label.text = "Syncing..."

        self.saveItDataList = SaveItDataList(withDelegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saveItDataList!.listItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "saveCell", for: indexPath) as! SaveTableViewCell
        
        let data = saveItDataList?.listItems[indexPath.row] as! SaveItData
        
        cell.titleLabel!.text = data.title
        cell.urlLabel!.text = data.url
        cell.descriptionLabel!.text = data.description
        //cell.imageView!.image = Resize.resizeImage(image: data.image, newWidth: 90, newHeight: 90)
        cell.savedAt!.text = data.savedAt
        cell.readView!.isHidden = data.read
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Mark as read
        var data = saveItDataList?.listItems[indexPath.row] as! SaveItData
        data.read = true;
        data.save()
        
        // Open the link
        if (data.url != "") {
            let url = URL(string: data.url)
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func options(_ sender: Any) {
        let actionSheet = UIAlertController.init(title: "SaveIt Settings", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction.init(title: "Cancel", style: .default, handler: { (action) in
            // close sheet
            actionSheet.dismiss(animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction.init(title: "Logout", style: UIAlertActionStyle.default, handler: { (action) in
            let firebaseAuth = FIRAuth.auth()
            do {
                try firebaseAuth?.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }))
    
        //Present the controller
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func markAllRead(_ sender: Any) {
        let toIndex = (saveItDataList?.listItems.count)! - 1
        
        for index in 0...toIndex {
            var data = saveItDataList?.listItems[index] as! SaveItData
            if data.read == false {
                data.read = true;
                data.save()
            }
        }
    }
    
    func readable(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.medium
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    // Mark SaveItDataList Delegate
    func listDidUpdate(dataList: SaveItDataList!) {
        // update the tableview when the data list is updated from observable
        self.tableView.reloadData()
        
        // hide the sync message if first time load
        if loadingNotification != nil {
            loadingNotification?.hide(animated: true)
        }
    }
}
