//
//  RecordListTableCell.swift
//  AssignmentXebia
//
//  Created by Deepak Chauhan on 12/22/19.
//  Copyright © 2019 Deepak Chauhan. All rights reserved.
//

import UIKit

class RecordListTableCell: UITableViewCell {

@IBOutlet weak var viewCellBG: UIView!
@IBOutlet weak var imgModuleIcon: UIImageView!
@IBOutlet weak var lblTitle: UILabel!
@IBOutlet weak var lblSubTitle: UILabel!
@IBOutlet weak var lblName: UILabel!
@IBOutlet weak var lblDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
