//
//  formDetailtblVc.swift
//  Star Cars
//
//  Created by Ritesh on 29/10/19.
//

import UIKit

class formDetailtblVc: UITableViewController {

    var data:NSArray = NSArray()
    var carBrandFlag:String?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(self.data)
        
       // searchBar.delegate = self as! UISearchBarDelegate
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "formTableCell", for: indexPath) as! formTableCell

        let value = self.data.object(at: indexPath.row) as! NSDictionary
        cell.cellImg.sd_setImage(with: URL(string: value.object(forKey: "image") as! String), placeholderImage: UIImage(named: "homeIcon") ,options: .refreshCached, completed: nil)
        if carBrandFlag == "carBrand" {
            cell.cellLbl.text = value.value(forKey: "brand_name") as? String
            
        } else if carBrandFlag == "fuelType" {
            cell.cellLbl.text = value.value(forKey: "fuel_type") as? String

        } else if carBrandFlag == "carModel" {
            cell.cellLbl.text = value.value(forKey: "model_name") as? String
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let clickedValue = self.data.object(at: indexPath.row) as! NSDictionary
        if carBrandFlag == "carBrand" {
            brandId = clickedValue.value(forKey: "id") as? Int
            selectedCarBrand = (clickedValue.value(forKey: "brand_name") as? String)!
            userSelectedCarBrand = (clickedValue.value(forKey: "brand_name") as? String)!
        } else if carBrandFlag == "carModel" {
            selectedCarModel = (clickedValue.value(forKey: "model_name") as? String)!
            userSelectedCarModel = selectedCarModel
        } else if carBrandFlag == "fuelType" {
            selectedFuelType = (clickedValue.value(forKey: "fuel_type") as? String)!
            userSelectedFuelType = selectedFuelType
        } else {
            
        }
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
