//
//  AppDelegate.swift
//

import UIKit

extension SceneDelegate {
    func switchVC(viewController: UIViewController) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let scene = UIApplication.shared.connectedScenes.first {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            let window: UIWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window.windowScene = windowScene
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            appDelegate.window = window
        }
    }
}
