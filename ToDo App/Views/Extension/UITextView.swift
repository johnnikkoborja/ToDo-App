//
//  UITextView.swift
//  ToDo App
//
//  Created by John Nikko Borja on 6/2/23.
//

import UIKit

extension UITextView {
    
    func addBorder() {
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.separator.cgColor
    }
}
