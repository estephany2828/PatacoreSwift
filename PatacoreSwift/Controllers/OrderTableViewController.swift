//
//  OrderTableViewController.swift
//  PatacoreSwift
//
//  Created by Telematica on 11/02/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
     var items = ["1", "2", "3"]

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTableViewCell
        cell.labelName.text = items[indexPath.row]
        cell.labelDescription.text = "Descripcion de " + items[indexPath.row]
        cell.textFieldAnnotation.text = "Anotaciones de " + items[indexPath.row]
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
