//
//  BaseViewController.swift
//

import UIKit

enum NavigationBarStyle {
    case polygon, normal
}

class BaseViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStyle(.polygon)
    }
}
