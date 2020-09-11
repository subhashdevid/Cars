//
//  HistoryVC.swift
//  Star Cars
//
//  Created by Ritesh on 08/01/20.
//

import UIKit
import SVProgressHUD
import Alamofire

class HistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var historyTableView: UITableView!
    
    var historyData:NSArray = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "History"

        if internetConnection.isConnectedToNetwork() == true {
        historyApi()
        }
        else {
            self.view.makeToast("please check your internet.", duration: 3.0, position: .bottom)
        }
        
        self.historyTableView.tableFooterView = UIView()
    }
    
    let USERID = UserDefaults.standard.string(forKey: "UserID")
    //print(USERID)

    func historyApi() {
        SVProgressHUD.show()
        Alamofire.request(historyUrl, method: .post, parameters: ["key": "5642vcb546gfnbvb7r6ewc211365vhh34", "userid": USERID],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success:
                print(response)
                let respArr = response.result.value as! NSArray
                let respdic = respArr.firstObject as! NSDictionary
                
                if respdic.object(forKey: "msg") as! String == "sucess" {
                    self.historyData = respdic.object(forKey: "data") as! NSArray
                }
                self.historyTableView.reloadData()
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HistoryCell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        
        cell.sethistoryCellData(historyData.object(at: indexPath.row) as! NSDictionary)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
    
    @IBAction func backBtnActn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        self.present(vc, animated: false, completion: nil)
    }
}
