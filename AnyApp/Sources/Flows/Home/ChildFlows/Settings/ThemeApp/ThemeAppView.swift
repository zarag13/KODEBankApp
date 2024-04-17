//
//  ThemeAppView.swift
//  AnyApp
//
//  Created by Kirill on 16.04.2024.
//

import UI
import UIKit
import AppIndependent

final class ThemeAppView: BackgroundPrimary {
    
    enum ThemeAppViewSettings {
        case content(title: String)
    }
    
    var content: [ThemeAppViewSettings] = [.content(title: "Как в системе"), .content(title: "Темная"), .content(title: "Светлая")]
    
    override func setup() {
        super.setup()
        body().embed(in: self)
    }
    
    func body() -> UIView {
        VStack {
            MainNavigationBar()
                .setuptile(title: "Тема приложения")
            ForEach(collection: content, alignment: .fill, distribution: .fill, spacing: 0, axis: .vertical) { content in
                //
            }
        }
    }
    
    func createThemeAppCell(content: ThemeAppViewSettings) -> UIView {
        switch content {
        case .content(title: let title):
            return View()
        }
    }
    
    
    func a(title: String) {
        //let
    }
}

