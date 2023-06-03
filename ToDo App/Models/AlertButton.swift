//
//  AlertButton.swift
//

import Foundation
import UIKit

class AlertButton {
    var title: String
    var isButtonOutlined: Bool
    var actionHandler: () -> Void

    init(with title: String, isButtonOutlined: Bool = false, actionHandler: @escaping () -> Void) {
        self.title = title
        self.isButtonOutlined = isButtonOutlined
        self.actionHandler = actionHandler
    }
}
