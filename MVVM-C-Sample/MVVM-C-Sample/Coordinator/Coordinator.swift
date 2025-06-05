//
//  Coordinator.swift
//  MVVM-C-Sample
//
//  Created by Umair on 12/05/2025.
//

import UIKit

protocol Coordinator{
    var navigationController : UINavigationController {get set}
    var childCoordinators : [Coordinator]? {get set}
    func start()
}
