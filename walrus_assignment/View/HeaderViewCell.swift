//
//  HeaderViewCell.swift
//  walrus_assignment
//
//  Created by Payal Kandlur on 16/09/21.
//

import UIKit

class HeaderViewCell: UITableViewCell {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        headerView.layer.cornerRadius = 15
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
