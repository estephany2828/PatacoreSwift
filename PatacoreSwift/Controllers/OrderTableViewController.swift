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
    var orderManager = OrdersManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        //db.dropTableProduct()
        
        
        //dataTestDB()
        //deleteprods()
        products = db.readProducts()
        //dataTestDB()
        //db.dropTableOrder()

    }
    
    func deleteprods(){
        db.deleteProductByID(id: 1)
        db.deleteProductByID(id: 2)

    }

    // MARK: - Table view data source
    func dataTestDB(){
        db.insertProduct(product: Product(name: "POLLO", price: 20000, description: "POLLO BIEN FRITO", imag: "hola"))
        db.insertProduct(product: Product(name: "CARNE", price: 15000, description: "CARNE ASADA", imag: "hola"))
        //db.insertProduct(product: Product(name: "ARROZ", price: 10000, description: "ARROZ BIEN MELO CARAMELO", imag: "hola"))
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
        
        cell.selectOrder.isOn = orderManager.issetOrder(id: products[indexPath.row].id, table: 1, state: 1)
        cell.labelName.text = products[indexPath.row].name
        cell.labelDescription.text = "Descripcion de " + products[indexPath.row].description
        cell.textFieldAnnotation.text = "Anotaciones de " + products[indexPath.row].name
        cell.cellDelegate = self
        cell.index = indexPath
        return cell
    }

}

extension OrderTableViewController: OrderTableView {
    
    
    func onClickCheck(index: Int, state: Bool) {
        print ("\(index) clicked is \(state)  \(products[index].id)")
        
        if (state){
            var order = Order(product: products[index], table: 1, state: 1, annotation: "Anotacion de \(products[index].name)", quantity: 2, date: "15/01/2019", hour: "2:03")
            
            orderManager.addOrder(order)
            
            
        }else{
            orderManager.removeOrder(id: products[index].id, table: 1, state: 1)
        }

    }
    
    func onClickPlus(index: Int, number: Int) {
        print ("\(index) clicked plus")
    }

    func onClickSustrain(index: Int, number: Int) {
        print ("\(index) clicked sustrain")
    }
    
    func onNumberTextChanged(index: Int, text: String) {
        print ("\(index) textChanged to: \(text)")
    }
    func onAnnotationEditEnd(index: Int, text: String) {
        print ("\(index) textChanged to: \(text)")
    }
    
    
    
}
