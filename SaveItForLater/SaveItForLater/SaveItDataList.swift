//
//  SaveItDataList.swift
//  SaveItForLater
//
//  Created by Jamie Lockhart on 2017-01-20.
//  Copyright © 2017 iLockhart. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import MBProgressHUD

protocol SaveItDataListDelegate {
    func listDidUpdate(dataList: SaveItDataList!)
}

class SaveItDataList: NSObject {
    var listItems: Array! = []
    var ref: FIRDatabaseReference!
    var refHandle: FIRDatabaseHandle!
    var delegate: SaveItDataListDelegate?
    
    init(withDelegate: SaveItDataListDelegate!) {
        super.init()
        
        self.delegate = withDelegate
        
        self.ref = FIRDatabase.database().reference()
        
        // grab all the saves for this user, update the list in real time
        let id = FIRAuth.auth()?.currentUser!.uid
        
        self.refHandle = ref.child("saves")
            .child(id!)
            .observe(FIRDataEventType.value, with: { (snapshot) in
                let postDict = snapshot.value as? [String : AnyObject] ?? [:]
                
                // kill the old array, append the new items and reload
                self.listItems.removeAll()
                
                for (key, dict) in postDict {
                    self.listItems.append(SaveItData(url: dict["url"] as! String,
                                                     title: dict["title"] as! String,
                                                     description: dict["description"] as! String,
                                                     image: dict["image"] as! String,
                                                     savedAt: dict["savedAt"] as! String,
                                                     read: dict["read"] as! Bool,
                                                     id: key))
                }
        
                // if the delegate was set, let them know we have new data to show
                if self.delegate != nil {
                    self.delegate!.listDidUpdate(dataList: self)
                }
            })
    }
}
