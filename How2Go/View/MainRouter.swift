//
//  MainRouter.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/28/17.
//  Copyright © 2017 How2Go. All rights reserved.
//
/// MainRoute class, used to initiate any ViewController class from any storyboard
import UIKit

class MainRouter {
    static func instantiateRouteViewController() -> RouteViewController {

        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RouteViewController") as! RouteViewController

        return viewController
    }

    static func instantiateRouteDetailsViewController() -> RouteViewController {

        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RouteDetailsViewController") as! RouteViewController

        return viewController
    }
}
