//
//  UIViewController.swift
//

import UIKit

extension UIViewController {
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    var sceneDelegate: SceneDelegate? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else { return nil }
        return delegate
    }

    var window: UIWindow? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
        return window
    }

    func setNavigationBarStyle(_ style: NavigationBarStyle = .polygon) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor : R.color.off_black()!
        ]

        // MARK: Navigation Bar Back button
        let backButton = UIBarButtonItem.appearance()
        let backButtonApperance = UIBarButtonItemAppearance()
        let backButtonTitleAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: R.color.global_blue()!,
        ]

        backButton.tintColor = R.color.global_blue()
        backButtonApperance.normal.titleTextAttributes = backButtonTitleAttributes
        backButtonApperance.highlighted.titleTextAttributes = backButtonTitleAttributes

        switch style {
        case .polygon:
            let image = R.image.navigation_bar_background()
            navBarAppearance.backgroundImageContentMode = .scaleAspectFill
            navBarAppearance.backgroundImage = image
            navBarAppearance.backgroundColor = .clear
            self.additionalSafeAreaInsets.top = 22
            // center items vertically
            let offset: CGFloat  = -4
            backButtonApperance.normal.titlePositionAdjustment.vertical = offset
            backButtonApperance.highlighted.titlePositionAdjustment.vertical = offset
            navBarAppearance.titlePositionAdjustment.vertical = offset
            if let height = navigationController?.navigationBar.frame.height {
                self.navigationController?.additionalSafeAreaInsets.top = -height/4
            }
        case .normal:
            navBarAppearance.backgroundImage = nil
            navBarAppearance.backgroundColor = R.color.global_yellow()
            self.additionalSafeAreaInsets.top = 0
            backButtonApperance.normal.titlePositionAdjustment.vertical = 0
            backButtonApperance.highlighted.titlePositionAdjustment.vertical = 0
            navBarAppearance.titlePositionAdjustment.vertical = 0
            self.navigationController?.additionalSafeAreaInsets.top = 0
        }

        navBarAppearance.shadowColor = nil
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.backButtonAppearance = backButtonApperance
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.navigationItem.backBarButtonItem = backButton
    }
    
    
    func isPresentingView(viewController: UIViewController) -> Bool {
        if presentationController?.presentingViewController.navigationItem.title == viewController.navigationItem.title {
            return true
        }
        return false
    }
    
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if let navigationController = navigationController, navigationController.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if let tabBarController = tabBarController, tabBarController.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
}
