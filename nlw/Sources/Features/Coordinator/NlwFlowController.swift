//
//  NlwFlowController.swift
//  NLW
//
//  Created by Niceplanet T.I on 14/12/24.
//

import Foundation
import UIKit

class NlwFlowController {
    private var navigationController: UINavigationController?
    
    public init() {
    }
    
    func start () -> UINavigationController? {
        let contentView = SplashView()
        let startViewController = SplashViewController(contentView: contentView, delegate: self)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        
        return navigationController
    }
    
}

extension NlwFlowController: SplashFlowDelegate {
    func decideNavigationFlow(){
        let contentView = WelcomeView()
        let welcomeViewController = WelcomeViewController(contentView: contentView)
        welcomeViewController.flowDelegate = self
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }
}


extension NlwFlowController: WelcomeFlowDelagate {
    func goToHome() {
        let homeViewController = HomeViewController()
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}
