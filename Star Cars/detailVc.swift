//
//  detailVc.swift
//  Star Cars
//
//  Created by Ritesh on 29/10/19.
//

import UIKit

class detailVc: UIViewController {

    @IBOutlet var img: UIImageView!
    @IBOutlet var dtlTitle: UILabel!
    @IBOutlet var desc: UILabel!
    
    var imgStr:String?
    var imgTitle:String?
    var descLbl:String?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Our Services"
        // Do any additional setup after loading the view.
        self.img.sd_setImage(with: URL(string: imgStr!), placeholderImage: UIImage(named: "homeIcon") ,options: .refreshCached, completed: nil)
        self.dtlTitle.text = imgTitle
        self.desc.text = descLbl
        
    }
    
    @IBAction func bookNowCtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "formVc") as! formVc
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
