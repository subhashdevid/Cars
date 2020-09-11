//
//  Headers.swift
//  Star Cars
//
//  Created by Ritesh on 28/10/19.
//

import Foundation
import UIKit


let registerUrl = "http://starcar.xyz/bimmer/index.php/registers"
let loginUrl = "http://starcar.xyz/bimmer/index.php/login"
let forgotPasswordUrl = "http://starcar.xyz/bimmer/index.php/forgetpassword"
let createPasswordUrl = "http://starcar.xyz/bimmer/index.php/create_newpass"
let getHomeDataUrl = "http://starcar.xyz/bimmer/index.php/gethomecategory"
let profileUrl = "http://starcar.xyz/bimmer/index.php/getprofile"
let contactUsUrl = "http://starcar.xyz/bimmer/index.php/get_contacts"
let fueltypeurl = "http://starcar.xyz/bimmer/index.php/getfuel_type_list"
let carModelUrl = "http://starcar.xyz/bimmer/index.php/getmodel"
let carBrandurl = "http://starcar.xyz/bimmer/index.php/getbrand"
let locationurl = "http://starcar.xyz/bimmer/index.php/getcity"
let getOtpUrl = "http://api.msg91.com/api/sendhttp.php"
let bookServiceUrl = "http://starcar.xyz/bimmer/index.php/book_service"
let historyUrl = "http://starcar.xyz/bimmer/index.php/getbookservice"

extension UIViewController {
    func showValidatorAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
}


}
