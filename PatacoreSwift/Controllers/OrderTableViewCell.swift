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
    func onClickCheck (index: Int, state: Bool)
    func onAnnotationEditEnd (index: Int, text: String)
    
    func onNumberTextChanged (index: Int, text: String)
}


class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var textFieldAnnotation: UITextField!
    @IBOutlet weak var textFieldNumber: UITextField!
    
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

    @IBAction func annotationEditingDidEnd(_ sender: Any) {
        cellDelegate?.onAnnotationEditEnd(index: (index?.row)!, text: (textFieldAnnotation.text)!)
    }
    @IBAction func numberTextChanged(_ sender: UITextField) {
        cellDelegate?.onNumberTextChanged(index: (index?.row)!, text: (textFieldNumber.text)!)
    }
    
    @IBAction func checkClick(_ sender: UISwitch) {
        cellDelegate?.onClickCheck(index: (index?.row)!, state: selectOrder.isOn)
    }
    
    
    @IBAction func plusClick(_ sender: UIButton) {
        cellDelegate?.onClickPlus(index: (index?.row)!, number: 1)
    }
    
    @IBAction func sustrainClick(_ sender: UIButton) {
        cellDelegate?.onClickSustrain(index: (index?.row)!, number: 1)
    }
    
}
