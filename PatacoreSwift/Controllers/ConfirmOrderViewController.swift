//
//  ConfirmOrderViewController.swift
//  PatacoreSwift
//
//  Created by Telematica on 3/03/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import UIKit

class ConfirmOrderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func cancelClick(_ sender: UIBarButtonItem) {
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
