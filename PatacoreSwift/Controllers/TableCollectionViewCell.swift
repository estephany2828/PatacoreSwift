//
//  TableCollectionViewCell.swift
//  PatacoreSwift
//
//  Created by Telematica on 11/02/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import UIKit

class TableCollectionViewCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init has not be implemented")
    }
    @IBOutlet weak var labelNumber: UILabel!
}
