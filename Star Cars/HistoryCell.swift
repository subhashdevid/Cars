//
//  HistoryCell.swift
//  Star Cars
//
//  Created by Ritesh on 08/01/20.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet var cateforyLbl: UILabel!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var mobilelbl: UILabel!
    @IBOutlet var addressLbl: UILabel!
    @IBOutlet var brandlbl: UILabel!
    @IBOutlet var modelLbl: UILabel!
    @IBOutlet var fueltypeLbl: UILabel!
    @IBOutlet var pickupLbl: UILabel!
    @IBOutlet var bookDateLbl: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func sethistoryCellData(_ historyDic : NSDictionary){
        cateforyLbl.text = historyDic.object(forKey: "service_category") as? String
        nameLbl.text = historyDic.object(forKey: "customer_name") as? String
        mobilelbl.text = historyDic.object(forKey: "mobile") as? String
        addressLbl.text = historyDic.object(forKey: "address") as? String
        brandlbl.text = historyDic.object(forKey: "brand") as? String
        modelLbl.text = historyDic.object(forKey: "model") as? String
        fueltypeLbl.text = historyDic.object(forKey: "fuel_type") as? String
        bookDateLbl.text = historyDic.object(forKey: "book_date") as? String
        pickupLbl.text = historyDic.object(forKey: "home_pickup") as? String
        cellView.backgroundColor = UIColor.red
        
    }
    
    
}
