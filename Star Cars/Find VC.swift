//
//  Find VC.swift
//  Star Cars
//
//  Created by Ritesh on 20/10/19.
//

import UIKit

class Find_VC: UIViewController, UITextViewDelegate {

    @IBOutlet var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.setupToHideKeyboardOnTapOnView()
        self.textView.text = "Description"
        self.textView.textColor = UIColor.lightGray
        self.textView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.textView.layer.borderWidth = 0.4
        self.textView.layer.borderColor = UIColor.darkGray.cgColor
        self.textView.layer.cornerRadius = 10.0
        
    }
    
    @IBAction func submitActn(_ sender: Any) {
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.textView.text = ""
        self.textView.textColor = UIColor.black
        return true
    }

    func textViewDidChange(_ textView: UITextView) {
        if self.textView.text.count == 0{
            self.textView.textColor = UIColor.lightGray
            self.textView.text = "Description"
            self.textView.resignFirstResponder()
        }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if self.textView.text.count == 0{
            self.textView.textColor = UIColor.lightGray
            self.textView.text = "Description"
            self.textView.resignFirstResponder()
        }
        return true
    }

}
