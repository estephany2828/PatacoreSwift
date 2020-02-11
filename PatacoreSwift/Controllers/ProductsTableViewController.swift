//
//  ProductsTableViewController.swift
//  PatacoreSwift
//
//  Created by Johana on 2/9/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    var productsManager: ProductsManger=ProductsManger()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        let product = productsManager.getProduct(at: indexPath.row)
        
        cell.textLabel?.text = product.name
        //cell.priceLabel?.text = product.price
        cell.detailTextLabel?.text = product.description
        cell.imageView?.image = product.img
        return cell
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
        productsManager.addProduct(product)
        tableView.reloadData()
    }
}

