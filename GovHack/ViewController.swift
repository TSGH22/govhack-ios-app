//
//  ViewController.swift
//  GovHack
//
//  Created by Max Chuquimia on 19/8/2022.
//

import UIKit
import SwiftUI

class ViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.pushViewController(UIHostingController(rootView: RootView()), animated: true)
    }
}
