//
//  formTableCell.swift
//  Star Cars
//
//  Created by Ritesh on 29/10/19.
//

import UIKit

class formTableCell: UITableViewCell {

    @IBOutlet var cellImg: UIImageView!
    @IBOutlet var cellLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
