//
//  CorgiNotchApp.swift
//  CorgiNotch
//
//  Created by Monu Kumar on 25/02/25.
//

import SwiftUI

@main
struct CorgiNotchApp: App {

    @NSApplicationDelegateAdaptor(CorgiAppDelegate.self) var corgiAppDelegate

    @ObservedObject private var appDefaults = AppDefaults.shared

    @State private var isMenuShown: Bool = true

    init() {
        self._isMenuShown = .init(
            initialValue: self.appDefaults.showMenuIcon
        )
    }

    var body: some Scene {
        MenuBarExtra(
            isInserted: $isMenuShown,
            content: {
                Text("CorgiNotch")

                NotchOptionsView()
            }
        ) {
            CorgiNotch.Assets.iconMenuBar
                .renderingMode(.template)
        }
        .onChange(
            of: appDefaults.showMenuIcon
        ) { oldVal, newVal in
            if oldVal != newVal {
                isMenuShown = newVal
            }
        }

        Settings {
            CorgiSettingsView()
        }
        .windowResizability(.contentSize)
    }
}
