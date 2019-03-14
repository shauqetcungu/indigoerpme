//
//  MenuCell.swift
//  Indigo
//
//  Created by Saša Vujanovic on 09/03/2019.
//  Copyright © 2019 Shauqet Cungu. All rights reserved.
//

import UIKit
import Kingfisher

class MenuCell: UITableViewCell {

    @IBOutlet weak var menuItemName: UILabel!
    @IBOutlet weak var menuItemImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(menu: Menu){
        menuItemName.text = menu.name
        menuItemImage.image = UIImage(named: "\(menu.image)")
    }
}
