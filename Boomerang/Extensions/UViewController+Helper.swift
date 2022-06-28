//
//  UViewController+Helper.swift
//  Boomerang
//
//  Created by Egor Laba on 28.06.22.
//

import UIKit

extension UIViewController {
    static func instantiate() -> Self  {
        let storyboardName = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateInitialViewController() as! Self
    }
}
