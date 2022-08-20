//
//  ViewController.swift
//  GovHack
//
//  Created by Max Chuquimia on 19/8/2022.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let v = UIHostingController(rootView: RootView())
        v.willMove(toParent: self)
        v.view.frame = view.bounds
        v.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(v.view)
        addChild(v)
        v.didMove(toParent: self)
    }
}
