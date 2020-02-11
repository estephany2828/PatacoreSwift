//
//  ProductViewController.swift
//  PatacoreSwift
//
//  Created by Johana on 2/10/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    var delegate: ProductViewControllerDelegate?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var imageTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func touchCancel(_ sender: UIBarButtonItem) {
        
     dismissMe()
        
    }
    
    
    @IBAction func touchSave(_ sender: UIBarButtonItem) {
        let productToSave = Product(id: 1, name: nameTextField.text!, price: priceTextField.text!, description: descriptionTextField.text!)
        delegate?.saveProduct(productToSave)
        dismissMe()
        
    }
    func dismissMe(){
        dismiss(animated: true, completion: nil)
    }
    
}

protocol ProductViewControllerDelegate{
    func saveProduct(_ product : Product)
}
