//
//  ProductsTableViewController.swift
//  PatacoreSwift
//
//  Created by Johana on 2/9/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import UIKit
import SDWebImage

class CustomCell: UITableViewCell{

    @IBOutlet var lblName: UILabel!
    @IBOutlet var imgProduct: UIImageView!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblPrice: UILabel!
    
}

class ProductsTableViewController: UITableViewController {
    var productsManager: ProductsManger=ProductsManger()
    
   
    @IBOutlet var TableProd: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        TableProd.dataSource = self
        TableProd.delegate = self
        productsManager.SQLInsertProduct()

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
        return productsManager.productCount
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CustomCell = self.tableView.dequeueReusableCell(withIdentifier: "productCell") as! CustomCell
        let product = productsManager.getProduct(at: indexPath.row)
        
        cell.lblName?.text = product.name
        cell.lblDescription?.text = product.description
        cell.lblPrice?.text = "$" + String(product.price)
        //cell.imgProduct?.image = product.img
        cell.imgProduct?.sd_setImage(with : URL(string: product.imag), placeholderImage: UIImage(named: "panadero.jpg"))
        
        
       
        //cell.textLabel?.text = product.name
        //cell.priceLabel?.text = product.price
        //cell.detailTextLabel?.text = product.description
        //cell.imageView?.image = product.img
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            
            productsManager.removeProduct(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow,
        let productViewController = segue.destination
            as? ProductViewController{
            productViewController.product = productsManager.getProduct(at: selectedIndexPath.row)
            productViewController.delegate = self
        } else if let navController = segue.destination as? UINavigationController{
            if let productViewController = navController.topViewController as? ProductViewController{
                productViewController.delegate = self
            }
        }
        
    }
    
  
   
   
}


extension ProductsTableViewController:ProductViewControllerDelegate{
    func saveProduct(_ product: Product) {
        
        if let selectIndexPath = tableView.indexPathForSelectedRow{
            productsManager.updateProduct(at: selectIndexPath.row, with: product)
        }else {
            productsManager.addProduct(product)
            
        }
     
        tableView.reloadData()
    }
}

