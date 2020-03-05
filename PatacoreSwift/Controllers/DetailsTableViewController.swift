//
//  DetailsTableViewController.swift
//  PatacoreSwift
//
//  Created by Johana on 2/10/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsTableViewController: UITableViewController {
    
    var productsManager: ProductsManger = ProductsManger()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productsManager.productCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detCell", for: indexPath)

        let detailsOrder = productsManager.getProduct(at: indexPath.row)
        cell.textLabel?.text = detailsOrder.name
        cell.detailTextLabel?.text = detailsOrder.description
        cell.imageView?.sd_setImage(with : URL(string: detailsOrder.imag), placeholderImage: UIImage(named: "panadero.jpg"))
        
        return cell
    }
   
    // override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     //   if let selectedIndexPath = tableView.indexPathForSelectedRow,
      //  let detailsViewController = segue.destination
        //    as? DetailsViewController{
          //  detailsViewController.detailsproduct
            //    = productsManager.getProduct(at: selectedIndexPath.row)
            ////detailsViewController.delegate = self
        //} else if let navController = segue.destination as? UINavigationController{
          //  if let detailsViewController = navController.topViewController as? DetailsViewController{
                //detailsViewController.delegate = self
            //}
        //}
        
    //}

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
