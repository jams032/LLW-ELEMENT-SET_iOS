//
//  CollectionViewCell.swift
//  LLW-ELEMENT-SET
//
//  Created by Jamshed Alam on 04/11/20.
//  Copyright © 13/11/2020 Jamshed Alam. All rights reserved.
//

import UIKit

protocol CollectionViewCellDelegate: class {
    func didChange(elementSet: ElementSet?)
}

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var elements: UILabel!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var replicaNo: UILabel!

    var elementSet: ElementSet?
    weak var delegate: CollectionViewCellDelegate?
    
    @IBAction func add(_ sender: Any) {
        if let value = Int(input.text ?? "") {
            elementSet?.add(value, timestamp: Date())
            delegate?.didChange(elementSet: self.elementSet)
            input.text = ""
        }
    }
    
    @IBAction func subtract(_ sender: Any) {
        if let value = Int(input.text ?? "") {
            elementSet?.remove(value, timestamp: Date())
            delegate?.didChange(elementSet: self.elementSet)
            input.text = ""
        }
    }
}
