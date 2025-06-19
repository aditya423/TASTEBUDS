//
//  Common.swift
//  TASTEBUDS
//
//  Created by Aditya on 19/06/25.
//

import UIKit
import SwiftLoader

func showLoader() {
    let parentView = UIView(frame: UIScreen.main.bounds)
    parentView.isUserInteractionEnabled = false
    var config : SwiftLoader.Config = SwiftLoader.Config()
    config.size = 105
    config.backgroundColor = .systemGray6
    config.spinnerColor = UIColor(red: 233/255, green: 28/255, blue: 26/255, alpha: 1.0)
    config.spinnerLineWidth = 5
    SwiftLoader.setConfig(config)
    SwiftLoader.show(animated: true)
    SwiftLoader.show(animated: true)
}

func hideLoader() {
    SwiftLoader.hide()
}
