//
//  StoryboardLocalization.swift
//

import UIKit

protocol Localizable {
    var localizeKey: String? { get set }
}

extension UILabel: Localizable {
    @IBInspectable var localizeKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}

extension UIButton: Localizable {
    @IBInspectable var localizeKey: String? {
        get { return nil }
        set(key) {
            UIView.performWithoutAnimation {
                setTitle(key?.localized, for: .normal)
                self.layoutIfNeeded()
            }
        }
    }
}

extension UINavigationItem: Localizable {
    @IBInspectable var localizeKey: String? {
        get { return nil }
        set(key) {
            title = key?.localized
        }
    }
}

extension UITextView: Localizable {
    @IBInspectable var localizeKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}

extension UIBarButtonItem: Localizable {
    @IBInspectable var localizeKey: String? {
        get { return nil}
        set (key) {
            title = key?.localized
        }
    }
}
