//
//  OrderTableViewController.swift
//  PatacoreSwift
//
//  Created by Telematica on 11/02/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {
    let db = DBHelper()
    var items = ["1", "2", "3"]
    var products:[Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
        db.deleteProductByID(id: 3)
        db.deleteProductByID(id: 4)
        db.deleteProductByID(id: 3)
        
        dataTestDB()
        products = db.readProducts()

    }

    // MARK: - Table view data source
    func dataTestDB(){
        db.insertProduct(product: Product(name: "POLLO", price: 20000, description: "POLLO BIEN FRITO", imag: "hola"))
        db.insertProduct(product: Product(name: "CARNE", price: 15000, description: "CARNE ASADA", imag: "hola"))
        db.insertProduct(product: Product(name: "ARROZ", price: 10000, description: "ARROZ BIEN MELO CARAMELO", imag: "hola"))
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTableViewCell
        items = []
        cell.labelName.text = products[indexPath.row].name
        cell.labelDescription.text = "Descripcion de " + products[indexPath.row].description
        cell.textFieldAnnotation.text = "Anotaciones de " + products[indexPath.row].name
        cell.cellDelegate = self
        cell.index = indexPath
        return cell
    }

}

extension OrderTableViewController: OrderTableView {
    
    
    
    func onClickCell(index: Int) {
        print ("\(index) clicked")
    }
    
    func onNumberTextChanged(index: Int, text: String) {
        print ("\(index) textChanged to: \(text)")
    }
    
    
    
}
