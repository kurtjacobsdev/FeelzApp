//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import UIKit

public class FeelzNavigationController: UINavigationController, UINavigationControllerDelegate {
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.isModalInPresentation = true
    }

    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        item.tintColor = .white
        viewController.navigationItem.backBarButtonItem = item
    }
}
