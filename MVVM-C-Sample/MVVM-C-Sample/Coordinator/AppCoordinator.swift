//
//  AppCoordinator.swift
//  MVVM-C-Sample
//
//  Created by Umair on 12/05/2025.
//

import UIKit

class AppCoordinator: Coordinator{
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator]?
    
    init(navigationController: UINavigationController, childCoordinators: [Coordinator]?) {
        self.navigationController = navigationController
        self.childCoordinators = childCoordinators
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "AppetizerList", bundle: .main)
        
        let vc = storyboard.instantiateViewController(identifier: "AppetizerListViewController") { coder in


            return AppetizerListViewController(coder: coder, viewModel: AppetizerListViewModel(service: AppetizerListService(networkManager: NetworkManager(manager: .shared))), coordinator: self)
            
//            return AppetizerListViewController(coder: coder, viewModel: AppetizerListViewModel(service: AppetizerListService()), coordinator: self)
        }
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToAppetizerDetail(appetizer: Appetizer){
        let storyboard = UIStoryboard(name: "AppetizerDetail", bundle: .main)
        
        let vc = storyboard.instantiateViewController(identifier: "AppetizerDetailViewController") { coder in
            return AppetizerDetailViewController(coder: coder, appetizer: appetizer)
        }
        
        self.navigationController.pushViewController(vc, animated: true)

    }
    
    
}
