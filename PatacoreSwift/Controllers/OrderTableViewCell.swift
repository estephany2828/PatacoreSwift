//
//  OrderTableViewCell.swift
//  PatacoreSwift
//
//  Created by Telematica on 11/02/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import UIKit


protocol OrderTableView {
    func onClickPlus (index: Int, number: Int)
    func onClickSustrain (index: Int, number: Int)
    func onClickCheck (index: Int, state: Bool, annotation: String)
    func onAnnotationTextChanged (index: Int, text: String)
    func onQuantityTextChanged (index: Int, quantity: Int)
}


class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var textFieldAnnotation: UITextField!
    @IBOutlet weak var textFieldNumber: UITextField!
    
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var selectOrder: UISwitch!
    var cellDelegate: OrderTableView?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
   
    @IBAction func annotationTextChanged(_ sender: UITextField) {
        cellDelegate?.onAnnotationTextChanged(index: (index?.row)!, text: (textFieldAnnotation?.text)!)
    }
    @IBAction func numberTextChanged(_ sender: UITextField) {
        let quantity = readQuantity()
        if (quantity > 0){
            selectOrder.isOn = true
        }
        cellDelegate?.onQuantityTextChanged(index: (index?.row)!, quantity: quantity)
    }
    
    @IBAction func checkClick(_ sender: UISwitch) {
        let state = selectOrder.isOn
        if state{
            textFieldNumber.text = "1"
        }else {
            textFieldNumber.text = "0"
        }
        cellDelegate?.onClickCheck(index: (index?.row)!, state: state, annotation: (textFieldAnnotation?.text)!)
    }
    
    
    @IBAction func plusClick(_ sender: UIButton) {
        var quantity = readQuantity()
        if (quantity >= 0){
            selectOrder.isOn = true
            quantity += 1
            textFieldNumber.text = String(quantity)
        }
        cellDelegate?.onQuantityTextChanged(index: (index?.row)!, quantity: quantity)
    }
    
    @IBAction func sustrainClick(_ sender: UIButton) {
        var quantity = readQuantity()
        if (quantity > 1){
            selectOrder.isOn = true
            quantity -= 1
            textFieldNumber.text = String(quantity)
        }
        cellDelegate?.onQuantityTextChanged(index: (index?.row)!, quantity: quantity)
    }
    
    func readQuantity ()->Int{
        var quantity:Int? = Int(textFieldNumber.text!)
        if (quantity == nil){
            quantity = 0
        }
        return quantity!
    }
    
}
