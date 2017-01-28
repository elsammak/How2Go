//
//  ViewController.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/27/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewController = MainRouter.instantiateRouteViewController()
        self.navigationController?.pushViewController(viewController, animated: false)
    }

}
