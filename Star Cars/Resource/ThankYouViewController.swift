//
//  ThankYouViewController.swift
//  Star Cars
//
//  Created by SUBHASH KUMAR on 11/09/20.
//

import UIKit

class ThankYouViewController: UIViewController {

    @IBOutlet var msgLbl: UILabel!
    @IBOutlet var homeBtn: UIButton!
    @IBOutlet var imgView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        self.imgView.layer.cornerRadius = 50
        self.imgView.layer.masksToBounds = true
        self.imgView.layer.borderColor = UIColor.black.cgColor
        self.imgView.layer.borderWidth = 2
        msgLbl.text = "Thanks for booking our services.\nWe will contact you soon"
        self.homeBtn.addTarget(self, action: #selector(redirectToHome), for: .touchUpInside)
        
    }
    

   @objc func redirectToHome(){
    self.navigationController?.popToRootViewController(animated: false)
    }

}
