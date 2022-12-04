//
//  AppDependency.swift
//  Practice1202
//
//  Created by Ellen J on 2022/12/02.
//

import UIKit

final class AppDependency {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
}

enum CompositionRoot {
    
    static func resolve(scene: UIWindowScene) -> AppDependency {
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = MainViewController.instance()
        window.backgroundColor = .clear
        return .init(window: window)
    }
}
