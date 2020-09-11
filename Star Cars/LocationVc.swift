//
//  LocationVc.swift
//  Star Cars
//
//  Created by Ritesh on 03/11/19.
//

import UIKit
import SVProgressHUD
import Alamofire

class LocationVc: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var data:NSArray = NSArray()

    @IBOutlet var collView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collView.delegate = self
        collView.dataSource = self
        locationApi()
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Select Location"

    }
    
    func locationApi() {
        SVProgressHUD.show()
        Alamofire.request(locationurl, method: .post, parameters: ["key": "5642vcb546gfnbvb7r6ewc211365vhh34"],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success:
                print(response)
                let respArr = response.result.value as! NSArray
                let respdic = respArr.firstObject as! NSDictionary
                
                if respdic.object(forKey: "msg") as! String == "sucess" {
                    self.data = respdic.object(forKey: "data") as! NSArray
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "formDetailtblVc") as! formDetailtblVc
//                    vc.data = self.data
//                    vc.carBrandFlag = "fuelType"
                    self.collView.reloadData()
//                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "locCell", for: indexPath) as! locCell
        
        let value = self.data.object(at: indexPath.row) as! NSDictionary
        print(value)
        cell.title.text = value.value(forKey: "city_name") as? String
        cell.imgView.sd_setImage(with: URL(string: value.value(forKey: "image") as! String), placeholderImage: UIImage(named: "homeIcon") ,options: .refreshCached, completed: nil)
//        cell.title.text = value.value(forKey: "city_name") as? String
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let value = self.data.object(at: indexPath.row) as! NSDictionary
        userCity = value.value(forKey: "city_name") as? String
        self.navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let collectionViewWidth = collView.bounds.width
        let collectionHeight = collView.bounds.height

        return CGSize(width: (collectionViewWidth - 60)/3, height: ((collectionHeight - 40)/5))

    }

}
