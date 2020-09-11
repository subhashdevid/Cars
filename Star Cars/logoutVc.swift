//
//  logoutVc.swift
//  Star Cars
//
//  Created by shashivendra  on 27/08/20.
//

import UIKit

class logoutVc: UIViewController {

    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var backBTn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        yesBtn.layer.cornerRadius = 5
        noBtn.layer.cornerRadius = 5

    }
    
        func showTimeActionSheet() {
       // Create the alert controller
            let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK Pressed")
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
               // NSLog("Cancel Pressed")
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
              
        }
    @IBAction func NoBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
         self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func yesBTN(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "UserID")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let navigationController = UINavigationController(rootViewController: newViewController)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window!.rootViewController = navigationController
    }
    
    @IBAction func backAction(_ sender: Any) {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            self.present(vc, animated: false, completion: nil)
            
        
    }
}
