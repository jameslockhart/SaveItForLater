//
//  SaveItData.swift
//  SaveItForLater
//
//  Created by Jamie Lockhart on 2017-01-20.
//  Copyright © 2017 iLockhart. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct SaveItData {
    var url: String
    var title: String
    var description: String
    var image: String
    var savedAt: String
    var read: Bool
    var id: String
    
    func getDictionary() -> NSDictionary {
        return [
            "url": self.url,
            "title": self.title,
            "description": self.description,
            "image": self.image,
            "savedAt": self.savedAt,
            "read": self.read
        ]
    }
    
    func save() {
        // Save update to firebase
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        let user = FIRAuth.auth()?.currentUser
        if (user != nil) {
            let userId = user!.uid
            ref.child("saves").child(userId).child(self.id).setValue(self.getDictionary())
        }
    }
}
