//
//  formVc.swift
//  Star Cars
//
//  Created by Ritesh on 29/10/19.
//

import UIKit
import SVProgressHUD
import Alamofire

class formVc: UIViewController, UITextViewDelegate {

    var data:NSArray = NSArray()
    var carBrandFlag:String?
    var carModelFlag:String?
    var selectedTime:String?
    var datePicker = UIDatePicker()
    

    
    @IBOutlet var textView: UITextView!
    @IBOutlet var BrandBtn: UIButton!
    @IBOutlet var modelBtn: UIButton!
    @IBOutlet var fuelBtn: UIButton!
    @IBOutlet var nameTxt: UITextField!
    @IBOutlet var addressTxt: UITextField!
    @IBOutlet var timeTxt: UITextField!
    @IBOutlet var dateTxt: UITextField!
    @IBOutlet var pickupBtn: UIButton!
    @IBOutlet var mobileTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mobileTxt.delegate = self
        mobileTxt.tag = 100
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isTranslucent = false
        self.setupToHideKeyboardOnTapOnView()

        self.textView.text = "Vehicle Description"
        self.textView.textColor = UIColor.lightGray
        self.textView.delegate = self
        showDatePicker()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.textView.layer.borderWidth = 0.4
        self.textView.layer.borderColor = UIColor.darkGray.cgColor
        self.textView.layer.cornerRadius = 10.0
        
        BrandBtn.setTitle(selectedCarBrand, for: .normal)
        modelBtn.setTitle(selectedCarModel, for: .normal)
        fuelBtn.setTitle(selectedFuelType, for: .normal)

//
////        if selectedCarBrand != nil {
//            BrandBtn.setTitle(selectedCarBrand, for: .normal)
//        } else if selectedCarModel != nil {
//            modelBtn.setTitle(selectedCarModel, for: .normal)
//        } else if selectedFuelType != nil {
//            fuelBtn.setTitle(selectedFuelType, for: .normal)
//        } else {
//
//        }
        
        
    }
    
    private func textFieldDidBeginEditing(textField: UITextField) {
        self.timeTxt.resignFirstResponder()
        //call your function here
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
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dateTxt.inputAccessoryView = toolbar
        dateTxt.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
                dateTxt.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        //        dateSelectedFlag = "yes"
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
//    func showTimeActionSheet() {
//        let alertController = UIAlertController(title: "Job Status", message: "Select Your job status.", preferredStyle: .actionSheet)
//        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        for item in self.delTimeArr{
//            let timeDic = item as! NSDictionary
//            let timeSlotBtn = UIAlertAction(title: timeDic.object(forKey: "time_slot") as? String , style: .default, handler: { (action) in
//                self.timeSlotName = timeDic.object(forKey: "time_slot") as? String
//                self.timeSlotId = timeDic.object(forKey: "time_slot_id") as? NSNumber
//                self.timeTxt.text = self.timeSlotName!
//                //print(self.timeSlotId!)
//            })
//            alertController.addAction(timeSlotBtn)
//        }
//        alertController.addAction(cancelButton)
//        self.present(alertController, animated: true, completion: nil)
//        
//    }
    
    let USERID = UserDefaults.standard.string(forKey: "UserID")
    func validation () {
        
       
        if self.nameTxt.text! == ""{
            self.view.makeToast("Please enter your name", duration: 3.0, position: .bottom)
        }
        else if self.mobileTxt.text! == "" {
            self.view.makeToast("Please enter your mobile number", duration: 3.0, position: .bottom)
        }
        else if self.addressTxt.text! == "" {
            self.view.makeToast("Please enter your address", duration: 3.0, position: .bottom)
        }
        else {
            SVProgressHUD.show()
            Alamofire.request(bookServiceUrl, method: .post, parameters: ["key": "5642vcb546gfnbvb7r6ewc211365vhh34", "userid":USERID ?? "","service_category": userCatId,"city": userCity,"customer_name": self.nameTxt.text!,"address": self.addressTxt.text ?? "","mobile": self.mobileTxt.text ?? "","brand": userSelectedCarBrand ?? "","model": userSelectedCarModel ?? "","fuel_type": userSelectedFuelType ?? "","home_pickup": userSelectedPickup ?? "","book_date": self.dateTxt.text!,"book_time": userSelectedTime ?? "","description": self.textView.text!],encoding: JSONEncoding.default, headers: nil).responseJSON {
                response in
                SVProgressHUD.dismiss()
                print(response)
                switch response.result {
                case .success:
//                    self.view.makeToast("Service Booked Succesfully.", duration: 3.0, position: .bottom)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "ThankYouViewController") as! ThankYouViewController
                              //        navigationController?.pushViewController(vc, animated: true)
                              //        self.present(vc, animated: true, completion: nil)
                              self.navigationController?.pushViewController(vc, animated: true)

                    break
                case .failure(let error):

                    print(error)
                }
            }
            
        }
    }
    
    
    @IBAction func submitActn(_ sender: Any) {
        self.view.endEditing(true)
        if internetConnection.isConnectedToNetwork() == true {
        validation()
        }
        else {
            self.view.makeToast("Please check your internet." ,duration: 3.0 ,position:.bottom)
        }
        
//        Alamofire.request(bookServiceUrl, method: .post, parameters: ["key": "5642vcb546gfnbvb7r6ewc211365vhh34", "userid":USERID,"service_category": userCatId,"city": userCity,"customer_name": self.nameTxt.text!,"address": self.addressTxt.text!,"mobile": self.mobileTxt.text,"brand": userSelectedCarBrand,"model": userSelectedCarModel,"fuel_type": userSelectedFuelType,"home_pickup": userSelectedPickup!,"book_date": self.dateTxt.text!,"book_time": userSelectedTime,"description": self.textView.text!],encoding: JSONEncoding.default, headers: nil).responseJSON {
//            response in
//            switch response.result {
//            case .success:
//                self.view.makeToast("Service booked succesfully.", duration: 3.0, position: .bottom)
//
//                break
//            case .failure(let error):
//
//                print(error)
//            }
//        }
    }
    
    @IBAction func carBrandActn(_ sender: UIButton) {
        getCarBrand()
    }
    
    @IBAction func carModelActn(_ sender: UIButton) {
        if brandId != nil {
            getCarModel()
        } else {
            self.view.makeToast("Please Select Brand")
        }
    }
    @IBAction func fueltypeActn(_ sender: UIButton) {
        if  internetConnection.isConnectedToNetwork() == true{
        getfuelType()
        }
        else  {
            self.view.makeToast("please check your internet.", duration: 3.0, position: .bottom)
        }
    }
    
    @IBAction func homePickupActn(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Need Home pickup?", message: "", preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Yes" , style: .default, handler: { (action) in
            
            self.pickupBtn.setTitle("Yes", for: .normal)
            userSelectedPickup = "Yes"
        })
        
        let noButton = UIAlertAction(title: "No" , style: .default, handler: { (action) in
            
            self.pickupBtn.setTitle("No", for: .normal)
            userSelectedPickup = "No"
        })
        
        
        alertController.addAction(yesButton)
        alertController.addAction(noButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getfuelType() {
        SVProgressHUD.show()
        Alamofire.request(fueltypeurl, method: .post, parameters: ["key": "5642vcb546gfnbvb7r6ewc211365vhh34"],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success:
                print(response)
                let respArr = response.result.value as! NSArray
                let respdic = respArr.firstObject as! NSDictionary

                if respdic.object(forKey: "msg") as! String == "sucess" {
                    self.data = respdic.object(forKey: "data") as! NSArray
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "formDetailtblVc") as! formDetailtblVc
                    vc.data = self.data
                    vc.carBrandFlag = "fuelType"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            break
            case .failure(let error):
                
                print(error)
            }
        }
    }

    func getCarModel() {
        SVProgressHUD.show()
        Alamofire.request(carModelUrl, method: .post, parameters: ["key": "5642vcb546gfnbvb7r6ewc211365vhh34", "brand_id": brandId ?? 0],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success:
                print(response)
                let respArr = response.result.value as! NSArray
                let respdic = respArr.firstObject as! NSDictionary
                
                if respdic.object(forKey: "msg") as! String == "sucess" {
                    self.data = respdic.object(forKey: "data") as! NSArray
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "formDetailtblVc") as! formDetailtblVc
                    vc.data = self.data
                    vc.carBrandFlag = "carModel"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func getCarBrand() {
        SVProgressHUD.show()
        Alamofire.request(carBrandurl, method: .post, parameters: ["key": "5642vcb546gfnbvb7r6ewc211365vhh34"],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success:
                print(response)
                self.carBrandFlag = "carBrand"
                let respArr = response.result.value as! NSArray
                print(respArr)
               let respdic = respArr.firstObject as! NSDictionary
                
                
                if respdic.object(forKey: "msg") as! String == "sucess" {
                    self.data = respdic.object(forKey: "data") as! NSArray
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "formDetailtblVc") as! formDetailtblVc
                    vc.data = self.data 
                    vc.carBrandFlag = self.carBrandFlag
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    func showActionSheet() {
        let alertController = UIAlertController(title: "Select Time", message: " ", preferredStyle: .actionSheet)
        
        let sendButton = UIAlertAction(title: "9:00am-12:00pm", style: .default, handler: { (action) -> Void in
            self.timeTxt.text = "9:00am-12:00pm"
            userSelectedTime = "9:00am-12:00pm"
        })
        
        let  deleteButton = UIAlertAction(title: "12:00pm-3:00pm", style: .default, handler: { (action) -> Void in
            self.timeTxt.text = "12:00pm-3:00pm"
            userSelectedTime = "12:00pm-3:00pm"
            
        })
        
        let cancelButton = UIAlertAction(title: "3:00pm-6:00pm", style: .default, handler: { (action) -> Void in
            self.timeTxt.text = "3:00pm-6:00pm"
            userSelectedTime = "3:00pm-6:00pm"
        })
        
        
        alertController.addAction(sendButton)
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        self.navigationController!.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func timeTxtAction(_ sender: Any) {
        self.showActionSheet()
    }
    
}

extension formVc: UITextFieldDelegate {
    
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
