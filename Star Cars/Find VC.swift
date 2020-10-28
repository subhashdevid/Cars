//
//  Find VC.swift
//  Star Cars
//
//  Created by Shikha on 20/10/19.
//

import UIKit
import Alamofire
import SVProgressHUD

class Find_VC: UIViewController, UITextViewDelegate {
    
    @IBOutlet var desctextView: UITextView!
    @IBOutlet var nameTextfield: UITextField!
    @IBOutlet var mobileTextfield: UITextField!
    @IBOutlet var titleTextfield: UITextField!
    
    var descriptionString = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.desctextView.text = "Description"
        self.desctextView.textColor = UIColor.lightGray
        self.desctextView.delegate = self
        self.mobileTextfield.tag = 100
        self.mobileTextfield.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.desctextView.layer.borderWidth = 0.4
        self.desctextView.layer.borderColor = UIColor.darkGray.cgColor
        self.desctextView.layer.cornerRadius = 10.0
        
    }
    
    @IBAction func submitActn(_ sender: Any) {
        validation()
        
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.desctextView.text = ""
        self.desctextView.textColor = UIColor.black
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        self.descriptionString = textView.text
        textView.resignFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if self.desctextView.text.count == 0{
            self.desctextView.textColor = UIColor.lightGray
            self.desctextView.text = "Description"
            self.desctextView.resignFirstResponder()
        }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if self.desctextView.text.count == 0 {
            self.desctextView.textColor = UIColor.lightGray
            self.desctextView.text = "Description"
            self.desctextView.resignFirstResponder()
        }
        return true
    }
    
    
    func validation () {
        var count = 0
        
        self.view.endEditing(true)
        
        if self.nameTextfield.text! == "" {
            count = count + 1
            self.view.makeToast("Please enter your name", duration: 3.0, position: .center)
            return
        }
        if self.mobileTextfield.text! == "" {
            count = count + 1
            self.view.makeToast("Please enter your mobile number", duration: 3.0, position: .center)
            return
        }
        
        if self.mobileTextfield.text?.count ?? 0 < 10 {
            count = count + 1
            self.view.makeToast("Please enter correct mobile number", duration: 3.0, position: .bottom)
            return
        }
        if self.titleTextfield.text! == ""{
            count = count + 1
            self.view.makeToast("Please enter title", duration: 3.0, position: .bottom)
            
            return
            
        }
        
        if !(self.validateDescriptionString(descString: self.descriptionString)) {
            self.view.makeToast("Please enter description", duration: 3.0, position: .bottom)
            count = count + 1
            
        }
        
        
        if count == 0 {
            self.apiCall()
        }
        
        
    }
    
    func validateDescriptionString( descString : String?) -> Bool {
        
        if descString == "Description" {
            return false
        }
        
        let trimmedString = descString?.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedString?.isEmpty ?? false {
            return false
        }
        
        return true
    }
    
    func apiCall() {
        SVProgressHUD.show()
        Alamofire.request(sendquery, method: .post, parameters: ["key": "5642vcb546gfnbvb7r6ewc211365vhh34", "name": nameTextfield.text ?? "","mobile": mobileTextfield.text ?? "","title": titleTextfield.text ?? "","description": self.desctextView.text!],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            print(response)
            let respDic = response.result.value as! NSDictionary
            SVProgressHUD.dismiss()
            switch response.result {
                
            case .success:
                let alert = UIAlertController(title: "Success!", message: respDic["msg"] as? String, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "ThankYouViewController") as! ThankYouViewController
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
                
                
                
                break
            case .failure(let error):
                
                print(error)
            }
        }
        
    }
    
    
}



extension Find_VC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField.tag == 100 {
            let charsLimit = 10

                   let startingLength = textField.text?.count ?? 0
                   let lengthToAdd = string.count
                   let lengthToReplace =  range.length
                   let newLength = startingLength + lengthToAdd - lengthToReplace

                   return newLength <= charsLimit
        }
       
        return true
    }
    
    

}



