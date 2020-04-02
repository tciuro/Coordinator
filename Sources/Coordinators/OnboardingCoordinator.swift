//  OnboardingCoordinator.swift
//  Coordinator-Example
//
//  Created by Dave Neff.

import UIKit

// MARK: - Delegate

protocol OnboardingCoordinatorDelegate: class {
    func onboardingCoordinatorDidFinish(_ coordinator: OnboardingCoordinator)
}

// MARK: - Coordinator

/** A Coordinator which takes a user through the first-time user / onboarding flow. */

final class OnboardingCoordinator: NavigationCoordinator {
    
    weak var delegate: OnboardingCoordinatorDelegate?
    
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController
    
    private let welcomeViewController: WelcomeViewController
    
    init() {
        let initialViewController = WelcomeViewController(title: "Welcome!",
                                                          description: "Welcome to the Onboarding Flow of this example project.\n\nCoordinators make it really easy to handle conditional routing like this.",
                                                          buttonTitle: "Cool")
        self.welcomeViewController = initialViewController
        
        let navigationController = UINavigationController(rootViewController: initialViewController)
        navigationController.navigationBar.isHidden = true
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    func start() {
        welcomeViewController.delegate = self
    }
    
}

// MARK: - Text and Button View Controller Delegate

extension OnboardingCoordinator: WelcomeViewControllerDelegate {
    
    func welcomeControllerDidTapButton(_ controller: WelcomeViewController) {
        let summaryViewController = SummaryViewController()
        summaryViewController.delegate = self
        navigator.push(summaryViewController, animated: true)
    }
    
}

// MARK: - Summary View Controller Delegate

extension OnboardingCoordinator: SummaryViewControllerDelegate {
    
    func summaryViewControllerDidTapButton(_ controller: SummaryViewController) {
        delegate?.onboardingCoordinatorDidFinish(self)
    }
    
}
