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
        let startViewController = SplashViewController(contentView: contentView)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        
        return navigationController
    }
}
