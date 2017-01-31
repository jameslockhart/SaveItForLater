//
//  SaveTableViewCell.swift
//  SaveItForLater
//
//  Created by Jamie Lockhart on 2017-01-20.
//  Copyright © 2017 iLockhart. All rights reserved.
//

import UIKit

class SaveTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var urlLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var metaImage: UIImageView?
    @IBOutlet weak var savedAt: UILabel?
    @IBOutlet weak var readView: UIView? 
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
