//
//  AppDelegate.swift
//  Bankey
//
//  Created by Zaytech Mac on 23/12/2024.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let loginViewController = LoginViewController()
    let onBoardingContainerViewController = OnboardingContainerViewController()
    let dummyViewController = DummyViewController()
    let mainViewController = MainViewController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginViewController.delegate = self
        onBoardingContainerViewController.delegate = self
        dummyViewController.delegate = self
        self.window?.rootViewController = mainViewController
        mainViewController.selectedIndex = 2
        return true
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        if (LocalState.hasOnboarded) {
            self.setRootViewController(dummyViewController)
        } else {
            self.setRootViewController(onBoardingContainerViewController)
        }
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnBoarding() {
        self.setRootViewController(dummyViewController)
        LocalState.hasOnboarded = true
    }
}

extension AppDelegate: LogoutDelegate {
    func didLogout() {
        self.setRootViewController(loginViewController)
    }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}
