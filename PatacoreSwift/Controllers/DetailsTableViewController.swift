//
//  DetailsTableViewController.swift
//  PatacoreSwift
//
//  Created by Johana on 2/10/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import UIKit
import SDWebImage
import BTNavigationDropdownMenu
class DetailsTableViewController: UITableViewController {
    //recursos para button down
    @IBOutlet weak var btnSelectTables: UIBarButtonItem!
   
    
   //@IBOutlet weak var selectedCellLabel: UILabel!
    //variables 
    var menuView: BTNavigationDropdownMenu!
    var productsManager: ProductsManger = ProductsManger()
    var ordeManag: OrdersManager = OrdersManager(table: 1)
    
    var orderManager = OrdersManager(table: 1)
    
    @IBOutlet weak var selectBtnMesa: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //aqui se coloca los valores de las mesas 
        let items = ["Mesa 1", "Mesa 2", "Mesa 3", "Mesa 4", "Mesa 5"]
            self.selectBtnMesa.text = items.first
            self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "Secondary")
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

            menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.index(2), items: items)

            // Another way to initialize:
            // menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.title("Dropdown Menu"), items: items)
            menuView.cellHeight = 50
            menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        menuView.cellSelectionColor = UIColor(named: "SecondaryLight")
            menuView.shouldKeepSelectedCellColor = true
            menuView.cellTextLabelColor = UIColor.white
            menuView.cellTextLabelFont = UIFont(name: "Mesa", size: 17)
            menuView.cellTextLabelAlignment = .left // .Center // .Right // .Left
            menuView.arrowPadding = 15
            menuView.animationDuration = 0.5
            menuView.maskBackgroundColor = UIColor.black
            menuView.maskBackgroundOpacity = 0.3
        
            menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> Void in
                print("Did select item at index: \(indexPath)")
                self.selectBtnMesa.text = items[indexPath]
              //  var pedidoMesa = self.ordeManag.getOrde(at: <#T##Int#>, tableP: <#T##Int#>, stateP: <#T##Int#>)
                let nromesa = indexPath + 1
                self.orderManager = OrdersManager(table: nromesa)
              
                //aqui colocar lo de desplegar
                //self.orderManager = OrdersManager(table: indexPath+1)
                
            }
            
            self.navigationItem.titleView = menuView
        
                    
    }
    

    //btn para seleccionar las mesas
    

    
    
    
        
          // MARK: - Table view data sourcer

    override func numberOfSections(in tableView: UITableView) -> Int {
              // #warning Incomplete implementation, return the number of sections
              return 1
          }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              // #warning Incomplete implementation, return the number of rows
        //return productsManager.productCount
            return orderManager.orderCount
          }

          
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCell(withIdentifier: "detCell", for: indexPath)
              //desde aqui modificas el cell

        //let detailsOrder  = productsManager.getProduct(at: indexPath.row)
        //cell.textLabel?.text = detailsOrder.name
        //cell.detailTextLabel?.text = detailsOrder.description
        //cell.imageView?.sd_setImage(with : URL(string: detailsOrder.imag), placeholderImage: UIImage(named: "panadero.jpg"))
              let detailsOrder = orderManager.getConfirmedOrders()
              cell.textLabel?.text = detailsOrder[indexPath.row].name
              cell.detailTextLabel?.text = detailsOrder[indexPath.row].description
              cell.detailTextLabel?.text = detailsOrder[indexPath.row].description
              cell.imageView?.sd_setImage(with : URL(string: detailsOrder[indexPath.row].imag), placeholderImage: UIImage(named: "panadero.jpg"))
              
              return cell
          }
        
    
    
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow,
        let detailsViewController = segue.destination
            as? DetailsViewController{
            detailsViewController.detailsOrder
                = ordeManag.getConfirmedOrders()[selectedIndexPath.row]
            ////detailsViewController.delegate = self
        } else if let navController = segue.destination as? UINavigationController{
            if let detailsViewController = navController.topViewController as? DetailsViewController{
                //detailsViewController.delegate = self
            }
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
