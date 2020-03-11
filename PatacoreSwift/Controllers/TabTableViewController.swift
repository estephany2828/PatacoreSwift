//
//  TabTableViewController.swift
//  PatacoreSwift
//
//  Created by Telematica on 10/03/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import UIKit

class TabTableViewController: UITableViewController {
    var table:Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    let items = [1,2,3,4,5]
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tabCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = String(items[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow,
        let navVC = segue.destination
            as? UINavigationController{
            let orderTableViewController = navVC.viewControllers.first as! OrderTableViewController
            orderTableViewController.table = Int(items[selectedIndexPath.row])
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            let table = self.items[indexPath.row]
            let alert = UIAlertController(title: "Vaciar Pedido de la mesa \(table)?", message: "Se vaciará el pedido", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                let db = DBHelper()
                db.deleteOrdersByState_Table(table: table, state: 1)
                db.deleteOrdersByState_Table(table: table, state: 2)
            }))

            self.present(alert, animated: true)
        }
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
