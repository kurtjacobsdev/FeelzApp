//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/24.
//

import UIKit

public extension UIViewController {
    func configureFeelzNavigationBar(title: String) {
        self.navigationItem.title = title

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = AppColor.viewBackground
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
