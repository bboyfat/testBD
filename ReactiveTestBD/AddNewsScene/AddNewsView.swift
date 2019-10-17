//
//  AddNewsView.swift
//  ReactiveTestBD
//
//  Created by Andrey Petrovskiy on 10/16/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import ReactiveKit
import Bond


class AddNewsView: UIView {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titileTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var addNewsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
