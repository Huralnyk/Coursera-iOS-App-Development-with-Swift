//
//  FilterCell.swift
//  Filterer
//
//  Created by Alexey Huralnyk on 12/1/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override var selected: Bool {
        didSet {
            if selected {
                imageView.layer.borderWidth = 2
                
            } else {
                imageView.layer.borderWidth = 0
            }
        }
    }
    
    func setup() {
        imageView.layer.borderColor = tintColor.CGColor
    }
    
    override func prepareForReuse() {
        imageView.layer.borderWidth = 0
    }
    
}
