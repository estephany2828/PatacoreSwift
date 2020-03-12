//
//  DetailsViewController.swift
//  PatacoreSwift
//
//  Created by Johana on 3/4/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import UIKit
import SDWebImage


class CellClasss: UITableView{
    
}

class DetailsViewController: UIViewController {
    var delegate: DetailsViewControllerDelegate?
    
    var detailsOrder: Order?
   
    
   
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var nombrePlato: UILabel!
    
    @IBOutlet weak var numPlatos: UILabel!
    
    @IBOutlet weak var anotaciones: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        if let detailsOrder = detailsOrder{
            nombrePlato.text = detailsOrder.name
            
            numPlatos.text = String(detailsOrder.quantity)
            
            anotaciones.text = detailsOrder.annotation
            
            imgView.sd_setImage(with : URL(string: detailsOrder.imag), placeholderImage: UIImage(named: "panadero.jpg"))
            
            
            
            
            
        }
        //let btn = UIButton(type: .custom)
       
        
        
        
       
        
    }

    
}

protocol DetailsViewControllerDelegate{
    func saveProduct(_ product : Product)
}

