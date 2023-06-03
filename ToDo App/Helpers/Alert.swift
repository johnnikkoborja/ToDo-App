//
//  Alert.swift
//  ToDo

import UIKit

struct Alert {
    private static func showBasicAlert(on vc: UIViewController, message: String) {
        let alert = UIAlertController(title: "Information", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true, completion: nil) }
    }
}
