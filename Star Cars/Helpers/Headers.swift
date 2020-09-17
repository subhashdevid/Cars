//
//  Headers.swift
//  Star Cars
//
//  Created by Ritesh on 28/10/19.
//

import Foundation
import UIKit

struct AppURL {
    static let BASE_URL = "http://starcar.xyz/bimmer/index.php/"
}


let registerUrl = "\(AppURL.BASE_URL)registers"
let loginUrl = "\(AppURL.BASE_URL)login"
let forgotPasswordUrl = "\(AppURL.BASE_URL)forgetpassword"
let forgetpassword_otp = "\(AppURL.BASE_URL)forgetpassword_otp"
let create_newpass = "\(AppURL.BASE_URL)create_newpass"

let createPasswordUrl = "\(AppURL.BASE_URL)create_newpass"
let getHomeDataUrl = "\(AppURL.BASE_URL)gethomecategory"
let profileUrl = "\(AppURL.BASE_URL)getprofile"
let contactUsUrl = "\(AppURL.BASE_URL)get_contacts"
let fueltypeurl = "\(AppURL.BASE_URL)getfuel_type_list"
let carModelUrl = "\(AppURL.BASE_URL)getmodel"
let carBrandurl = "\(AppURL.BASE_URL)getbrand"
let locationurl = "\(AppURL.BASE_URL)getcity"
let getOtpUrl = "http://api.msg91.com/api/sendhttp.php"
let bookServiceUrl = "\(AppURL.BASE_URL)book_service"
let historyUrl = "\(AppURL.BASE_URL)getbookservice"
let homeCategory = "\(AppURL.BASE_URL)gethomecategory"
let sendquery = "\(AppURL.BASE_URL)send_query"


extension UIViewController {
    func showValidatorAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
}


}
