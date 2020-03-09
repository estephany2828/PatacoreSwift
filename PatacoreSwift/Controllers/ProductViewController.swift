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
    
    var product: Product?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var imageTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        if let product = product {
            imageTextField.text = product.imag
            nameTextField.text = product.name
            priceTextField.text = String(product.price)
            descriptionTextField.text = product.description
            navigationItem.title = "Editar Productos"
            print("editar produc")
            print(product.id)
            
            
        }
    }
    

    @IBAction func touchCancel(_ sender: UIBarButtonItem) {
        
     dismissMe()
        
    }
    
    // cuando le damos click guarda
    @IBAction func touchSave(_ sender: UIBarButtonItem) {
        let productToSave = Product(id: product?.id, name: nameTextField.text!, price: Int(priceTextField.text!)!, description: descriptionTextField.text!, imag: imageTextField.text!
                                    )
        
        delegate?.saveProduct(productToSave)
        dismissMe()
        
    }
    func dismissMe(){
        if presentingViewController != nil {
            dismiss(animated: true, completion: nil)
            
        }else{
            navigationController!.popViewController(animated: true)
        }
        
    }
    
}

protocol ProductViewControllerDelegate{
    func saveProduct(_ product : Product)
}
