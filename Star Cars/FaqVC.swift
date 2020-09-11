//
//  FaqVC.swift
//  Star Cars
//
//  Created by Ritesh on 17/11/19.
//

import UIKit

class FaqVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

self.title = "FAQ"
        
    }
    

    @IBAction func backActn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        self.present(vc, animated: false, completion: nil)
        
    }
    
}
