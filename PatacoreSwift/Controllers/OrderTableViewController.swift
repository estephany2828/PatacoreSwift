//
//  OrderTableViewController.swift
//  PatacoreSwift
//
//  Created by Telematica on 11/02/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import UIKit
import SDWebImage

class OrderTableViewController: UITableViewController {
    
    
    @IBOutlet var tableViewOrder: UITableView!
    let db = DBHelper()
    var items = ["1", "2", "3"]
    var products:[Product] = []
    var orderManager = OrdersManager(table: 1)
    
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
    
    @IBAction func btnReturn(_ sender: UIBarButtonItem) {
        dismissMe()
    }
    
    func dismissMe(){
        if presentingViewController != nil {
            dismiss(animated: true, completion: nil)
            
        }else{
            navigationController!.popViewController(animated: true)
        }
        
    }
    
    func deleteprods(){
        db.deleteProductByID(id: 1)
        db.deleteProductByID(id: 2)

    }

    @IBAction func confirmClicked(_ sender: UIBarButtonItem) {
        let changes: String = self.orderManager.detectChanges(table: 1)
        let alert = UIAlertController(title: "Aceptar Cambios?", message: changes, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
            self.orderManager.actOrders()
        }))

        self.present(alert, animated: true)
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
        let order: Order? =  orderManager.getOrder(idProd: products[indexPath.row].id)
        if (order != nil){
            cell.selectOrder.isOn = true
            cell.textFieldAnnotation.text = order!.annotation
            cell.textFieldNumber.text = String(order!.quantity)
        }else{
            cell.selectOrder.isOn = false
            cell.textFieldAnnotation.text = ""
            cell.textFieldNumber.text = "0"
        }
        
        cell.imageProduct?.sd_setImage(with : URL(string: products[indexPath.row].imag), placeholderImage: UIImage(named: "panadero.jpg"))
        cell.labelName.text = products[indexPath.row].name
        cell.labelDescription.text = products[indexPath.row].description
        
        cell.cellDelegate = self
        cell.index = indexPath
        return cell
    }

}

extension OrderTableViewController: OrderTableView {

    func onClickCheck(index: Int, state: Bool, annotation: String) {
        print ("\(index) clicked is \(state)  \(products[index].id)")
        
        if (state){
            let order = Order(product: products[index], table: 1, state: 1, annotation: annotation, quantity: 1, date: "15/01/2019", hour: "2:03")
            orderManager.addOrder(order)
        }else{
            orderManager.removeOrder(id: products[index].id)
        }

    }
    
    func onClickPlus(index: Int, number: Int) {
        print ("\(index) clicked plus")
    }

    func onClickSustrain(index: Int, number: Int) {
        print ("\(index) clicked sustrain")
    }
    
    func onQuantityTextChanged(index: Int, quantity: Int) {
        print ("\(index) textChanged")
        
        if (orderManager.issetOrder(id: products[index].id)){
            orderManager.updateOrderQuantity(product: products[index], quantity: quantity)
        }else{
            orderManager.addOrder(Order(product: products[index], table: 1, state: 1, annotation: "", quantity: quantity, date: "15/01/2019", hour: "2:03"))
        }
    }
    
    func onAnnotationTextChanged(index: Int, text: String) {
        print ("\(index) textChanged to: \(text)")
        if (orderManager.issetOrder(id: products[index].id)){
            orderManager.updateOrderAnnotation(product: products[index], annotation: text)
        }
        
    }
    
}
