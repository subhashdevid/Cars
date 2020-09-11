//
//  placeVc.swift
//  Star Cars
//
//  Created by Ritesh on 03/11/19.
//

import UIKit
import SVProgressHUD
import Alamofire

private let reuseIdentifier = "locCell"


class placeVc: UICollectionViewController {

    var data:NSArray = NSArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        locationApi()
        // Do any additional setup after loading the view.
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
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! locCell
    
        // Configure the cell
//        let cell = collView.dequeueReusableCell(withReuseIdentifier: "locCell", for: indexPath) as! locCell
        
        let value = self.data.object(at: indexPath.row) as! NSDictionary
        cell.imgView.sd_setImage(with: URL(string: value.object(forKey: "image") as! String), placeholderImage: UIImage(named: "homeIcon") ,options: .refreshCached, completed: nil)
        cell.title.text = value.value(forKey: "city_name") as? String
        return cell
    
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
