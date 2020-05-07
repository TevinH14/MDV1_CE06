//
//  StoreTableViewCell.swift
//  HamiltonTevin_CE06
//
//  Created by Tevin Hamilton on 9/18/19.
//  Copyright © 2019 Tevin Hamilton. All rights reserved.
//

import UIKit

class StoreTableViewCell: UITableViewCell {
    @IBOutlet weak var labelStoreName: UILabel!
    @IBOutlet weak var labelNumStores: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
