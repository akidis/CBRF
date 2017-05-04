//
//  MoneyTableViewCell.swift
//  CBRF
//
//  Created by Andrey Kiselev on 01.05.17.
//  Copyright © 2017 Andrey Kiselev. All rights reserved.
//

import UIKit

class MoneyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var translateValute: UILabel!
    @IBOutlet weak var nameMoney: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageRate: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
