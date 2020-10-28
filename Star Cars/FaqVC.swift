//
//  FaqVC.swift
//  Star Cars
//
//  Created by Ritesh on 17/11/19.
//

import UIKit


class FAQCell :  UITableViewCell {
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var subTitleLbl: UILabel!

}

class FaqVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet var tblView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "FAQ"
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "FAQCell") as? FAQCell
        
        if indexPath.row == 0 {
            cell?.titleLbl.text = "Q: What is Star Cars?"
            cell?.subTitleLbl.text = "Star Cars is a network of technology-enabled car service centres, offering a seamless service experience at the convenience of a tap. With our highly skilled technicians, manufacturer recommended procedures and the promise of genuine spare parts, we are your best bet."
        }
        else if indexPath.row == 1 {
            cell?.titleLbl.text = "Q: Why should I choose Star Cars?"
            cell?.subTitleLbl.text = "Star Cars offers the best car services and solutions at fair and flexible prices. You end up saving up to 40% compared to what is charged at Authorised Service Centres and Multi-brand workshops."

        }
        else if indexPath.row == 2 {
            cell?.titleLbl.text = "Q:How can you offer 40% savings on service charges?"
            cell?.subTitleLbl.text = "Our distinctive business model enables us to provide affordable car services. We achieve savings on labour costs, centralized bulk procurement of spare parts, no real-estate overheads, and adept operational excellence, which are passed on straight to You- the Customer."

        }
        else if indexPath.row == 3 {
            cell?.titleLbl.text = "Q: How is Star Cars different from other service platforms out there?"
            cell?.subTitleLbl.text = "Unlike other platforms, we do not work on a lead generation model. Uncompromised customer gratification is our idea of fulfilment, that is why we own the complete experience right from procurement of spare parts to quality control at our partner car service centres. Our Customer Representative will be on ground duty promptly reporting every development directly to you. Star Cars is your personal car service expert and partner rolled into one."

        }
        else if indexPath.row == 4 {
            cell?.titleLbl.text = "Q: Where can I book a car service with Star Cars?"
            cell?.subTitleLbl.text = "You can book a Star Cars car service directly from our website or by App. Want a more human experience? call or WhatsApp on +91 9999999116"

        }
        else if indexPath.row == 5 {
            cell?.titleLbl.text = "Q: How to book a car service with Star Cars?"
            cell?.subTitleLbl.text = "We have made booking a car service as easy as 1-2-3. Just select you Car's make, model and fuel type, select the type of car. We have made booking a car service as easy as 1-2-3.."

        }
        else if indexPath.row == 6 {
            cell?.titleLbl.text = "Q: What if I am not available to  drop my car?"
            cell?.subTitleLbl.text = "Worry not! We'll take care of everything. We offer free pick-up and drop-in."

        }
        else if indexPath.row == 7 {
            cell?.titleLbl.text = "Q: Do I have to pay before the service?"
            cell?.subTitleLbl.text = "Not at all. From the booking to delivery, our priority at Star Cars keeps You and Your Car Service first. We will send you the bill once your car is serviced and inspected by our professionals. We offer flexible payment options for your ease. You can still prepay if you choose to."

        }
        
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
}
