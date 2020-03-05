//
//  DetailsViewController.swift
//  PatacoreSwift
//
//  Created by Johana on 3/4/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import UIKit
import SDWebImage


class DetailsViewController: UIViewController {
    var delegate: DetailsViewControllerDelegate?
    
    var detailsproduct: Product?
    
    

    @IBOutlet weak var imgView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let detailsOrder = detailsproduct{
           //nameText.text = detailsproduct?.name
            
            //nroPlatosText.text = String(detailsproduct!.price)
            
            //descriptionText.text = detailsproduct?.description
            
            imgView.sd_setImage(with : URL(string: detailsproduct!.imag), placeholderImage: UIImage(named: "panadero.jpg"))
            
            
            
            
            
        }
    }
    

    

}

protocol DetailsViewControllerDelegate{
    func saveProduct(_ product : Product)
}
