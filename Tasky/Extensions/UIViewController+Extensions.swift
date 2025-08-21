//
//  UIViewController+Extensions.swift
//  Tasky
//
//  Created by Archana Kumari on 21/08/25.
//

import Foundation
import UIKit

extension UIViewController {

    func presentViewController(viewController: UIViewController, withTitle title: String?, withAnimation animated: Bool ) {
        viewController.navigationItem.title = title
        navigationController?.pushViewController(viewController, animated: animated)
    }
}
