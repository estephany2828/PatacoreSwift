//
//  DetailsTableViewController.swift
//  PatacoreSwift
//
//  Created by Johana on 2/10/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import UIKit
import SDWebImage

class CellClass: UIViewController{
    
}

class DetailsTableViewController: UITableViewController {
    //recursos para button down
    @IBOutlet weak var btnSelectTables: UIBarButtonItem!
    let transparentView = UIView()
    let tableViewTable = UITableView()
    var selectButton = UIBarButtonItem()
    var dataSource = [String]()
    
    
    
    
    var productsManager: ProductsManger = ProductsManger()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableViewTable.delegate = self
        //tableViewTable.dataSource = self
        //tableViewTable.register(CellClass.self, forCellReuseIdentifier: "cell")

      
    }
   
    func addTransparentView(frames: CGRect ){
        let windows = UIApplication.shared.keyWindow
        transparentView.frame = windows?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableViewTable.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableViewTable)
        tableViewTable.layer.cornerRadius = 5
        
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        tableViewTable.reloadData()
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0,  initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableViewTable.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: CGFloat(self.dataSource.count*50))
        }, completion: nil)
        
    }
    @objc func removeTransparentView(){
        let frames = selectButton.accessibilityFrame
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0,  initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableViewTable.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    //btn para seleccionar las mesas
    
  
    
    @IBAction func onClickSelectTable(_ sender: Any) {
       // dataSource = ["1", "2", "3"]
         //      selectButton = btnSelectTables
           //    addTransparentView(frames: btnSelectTables.accessibilityFrame)
    }
    // MARK: - Table view data sourcer

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
   
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow,
        let detailsViewController = segue.destination
            as? DetailsViewController{
            detailsViewController.detailsproduct
                = productsManager.getProduct(at: selectedIndexPath.row)
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
