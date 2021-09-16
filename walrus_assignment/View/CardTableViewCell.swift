//
//  CardTableViewCell.swift
//  walrus_assignment
//
//  Created by Payal Kandlur on 14/09/21.
//

import UIKit
import WebKit

class CardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var seeNewsBtn: UIButton!
    @IBOutlet weak var cardView: UIView!
    
    fileprivate var seeNewsAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addContent()
    }
    
    func addContent() {
        cardView.layer.cornerRadius = 5
        seeNewsBtn.layer.cornerRadius = 5
        imgView?.layer.cornerRadius = 5
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func seeNewsBtnTapped(_ sender: Any) {
        if let function = seeNewsAction {
            function()
        }
    }
    
    func setSeeNewsActionType(callBackFunc:@escaping (() -> Void)) {
        seeNewsAction = callBackFunc
    }
    
}
