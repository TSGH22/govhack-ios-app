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

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let swiftUI = Test()
            let v = UIHostingController(rootView: swiftUI)
            self.present(v, animated: true)
        }
    }


}


struct Test: View {

    var body: some View {
        Color.red
    }

}
