//
//  Home VC.swift
//  Star Cars
//
//  Created by Ritesh on 20/10/19.
//

import UIKit
import Alamofire
import SideMenu
import SDWebImage

class Home_VC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var locBtn: UIButton!
    @IBOutlet var collView: UICollectionView!
    @IBOutlet var findView: UIView!
    @IBOutlet var imgOne: UIImageView!
    @IBOutlet var bannerCollView: UICollectionView!
    @IBOutlet var imgtwo: UIImageView!
    var categoryArr:NSArray = NSArray()
    var bannerArr:NSArray = NSArray()
    var secondBannerArr:NSArray = NSArray()
    
    
    
    var text = ["Mechanical or Electrical Repair","Mechanical or Electrical Repair","Mechanical or Electrical Repair","Mechanical or Electrical Repair","Mechanical or Electrical Repair","Mechanical or Electrical Repair"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "StarCars"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        findView.addGestureRecognizer(tap)
        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuWidth = (UIScreen.main.bounds.size.width/4)*2
        setupSideMenu()
        startTimer()
        collView.isScrollEnabled = false
        if internetConnection.isConnectedToNetwork() == true{
            getHomeData()
        }
        else {
            self.view.makeToast("please check your internet.", duration: 3.0, position: .bottom)
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.findView.layer.borderWidth = 0.5
        self.findView.layer.borderColor = UIColor.black.cgColor
        if userCity != nil {
            self.locBtn.setTitle(userCity!, for: .normal)
        }
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "StarCars"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        
    }
    
    func startTimer() {
        
        let timer =  Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        
        if let coll  = bannerCollView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)! < bannerArr.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }
                
            }
        }
    }
    
    @IBAction func locActn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocationVc") as! LocationVc
        //        navigationController?.pushViewController(vc, animated: true)
        //        self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collView {
            return text.count
        } else {
            return self.bannerArr.count
        }
    }
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollCell", for: indexPath) as! HomeCollCell
            cell.cellLbl.text = text[indexPath.row]
            cell.cellView.layer.borderWidth = 0.3
            cell.cellView.layer.cornerRadius = 10.0
            cell.cellView.layer.borderColor = UIColor.lightGray.cgColor
            
            if self.categoryArr.count > 0 {
                let value = self.categoryArr.object(at: indexPath.row) as! NSDictionary
                cell.cellImg.sd_setImage(with: URL(string: value.object(forKey: "image") as! String), placeholderImage: UIImage(named: "homeIcon") ,options: .refreshCached, completed: nil)
                cell.cellLbl.text = value.value(forKey: "title") as? String
            }
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollCell", for: indexPath) as! BannerCollCell
            let value = self.bannerArr.object(at: indexPath.row) as! NSDictionary
            cell.bannerCellImg.sd_setImage(with: URL(string: value.object(forKey: "image") as! String), placeholderImage: UIImage(named: "homeIcon") ,options: .refreshCached, completed: nil)
            
            return cell
        }
        
        //        return UICollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collView {
            if userCity == nil {
                self.view.makeToast("Please select your location.", duration: 3.0, position: .bottom)
            } else {
                let clickedValue = self.categoryArr.object(at: indexPath.row) as! NSDictionary
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "detailVc") as! detailVc
                userCatId = clickedValue.value(forKey: "title") as? String
                vc.imgStr = clickedValue.value(forKey: "image") as? String
                vc.imgTitle = clickedValue.value(forKey: "title") as? String
                vc.descLbl = clickedValue.value(forKey: "description") as? String
                navigationController?.pushViewController(vc, animated: true)
                
            }
            
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collView {
            let collectionViewWidth = collView.bounds.width
            let collectionHeight = collView.bounds.height
            
            return CGSize(width: (collectionViewWidth - 60)/3, height: ((collectionHeight - 40)/1.9))
            
        } else {
            let collectionViewWidth = bannerCollView.bounds.width
            let collectionHeight = bannerCollView.bounds.height
            
            return CGSize(width: (collectionViewWidth), height: (collectionHeight))
            
        }
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Find_VC") as! Find_VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //    func getHomeData() {
    //        let params = ["key": "5642vcb546gfnbvb7r6ewc211365vhh34"]
    //        let homeurl = "http://starcar.xyz/bimmer/index.php/gethomecategory"
    //        NetworkEngine.sharedInstance.postRequestHandler(homeurl, isBaseAuthorized: false, params: params as Dictionary<String, AnyObject>, completionHandler: { ( response: AnyObject?, error:NSError?, httpStatusCode:Int?) in
    //            DispatchQueue.main.async(execute: {
    //                if error == nil && response != nil {
    //                    print(response!)
    //                    let alert = UIAlertController(title: "Success!", message: "Password updated successfully.", preferredStyle: .alert)
    //                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
    //                        self.navigationController?.popViewController(animated: true)
    //                    }))
    //                    self.present(alert, animated: true, completion: nil)
    //                }
    //            })
    //        })
    //    }
    func getHomeData() {
        let urlString = "http://starcar.xyz/bimmer/index.php/gethomecategory"
        Alamofire.request(urlString, method: .post, parameters: ["key": "5642vcb546gfnbvb7r6ewc211365vhh34"],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                let respArr = response.result.value as! NSArray
                let respDic = respArr.firstObject as! NSDictionary
                print(respDic)
                self.bannerArr = respDic.object(forKey: "banner") as! NSArray
                self.categoryArr = respDic.object(forKey: "category") as! NSArray
                self.secondBannerArr = respDic.object(forKey: "second_banner") as! NSArray
                
                let value = self.secondBannerArr.firstObject as! NSDictionary
                self.imgOne.sd_setImage(with: URL(string: value.object(forKey: "image") as! String), placeholderImage: UIImage(named: "homeIcon") ,options: .refreshCached, completed: nil)
                let values = self.secondBannerArr.lastObject as! NSDictionary
                self.imgtwo.sd_setImage(with: URL(string: values.object(forKey: "image") as! String), placeholderImage: UIImage(named: "homeIcon") ,options: .refreshCached, completed: nil)
                
                
                self.collView.reloadData()
                self.bannerCollView.reloadData()
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    private func setupSideMenu() {
        
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
        
        
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
    }
}
