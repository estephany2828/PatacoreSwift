//
//  OrderTableViewCell.swift
//  PatacoreSwift
//
//  Created by Telematica on 11/02/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import UIKit


protocol OrderTableView {
    func onClickCell (index: Int)
    
    func onNumberTextChanged (index: Int, text: String)
}


class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var textFieldAnnotation: UITextField!
    @IBOutlet weak var textFieldNumber: UITextField!
    
    var cellDelegate: OrderTableView?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    @IBAction func numberTextChanged(_ sender: UITextField) {
        cellDelegate?.onNumberTextChanged(index: (index?.row)!, text: (textFieldNumber.text)!)
    }
    
    @IBAction func checkClick(_ sender: UISwitch) {
        cellDelegate?.onClickCell(index: (index?.row)!)
    }
    
    
    @IBAction func sumClick(_ sender: UIButton) {
        cellDelegate?.onClickCell(index: (index?.row)!)
    }
}
