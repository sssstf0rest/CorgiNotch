//
//  UpdaterViewModel.swift
//  CorgiNotch
//
//  Created by Monu Kumar on 03/01/26.
//

import SwiftUI
import Sparkle

final class UpdaterViewModel: NSObject, ObservableObject, SPUStandardUserDriverDelegate {
    
    static let shared = UpdaterViewModel()
    
    @Published private(set) var canCheckForUpdates = true
    @Published private(set) var currentVersion = ""
    
    private var updaterController: SPUStandardUpdaterController!
    private var hasStartedUpdater = false
    
    override init() {
        super.init()
        currentVersion = Self.makeCurrentVersionString()
        self.updaterController = SPUStandardUpdaterController(
            startingUpdater: false,
            updaterDelegate: nil,
            userDriverDelegate: self
        )
        _ = startUpdaterIfNeeded(showErrorToUser: false)
    }
    
    var supportsGentleScheduledUpdateReminders: Bool {
        return true
    }
    
    func checkForUpdates() {
        guard startUpdaterIfNeeded(showErrorToUser: true) else {
            return
        }
        
        updaterController.checkForUpdates(nil)
        refreshUpdaterAvailability()
    }
    
    @discardableResult
    private func startUpdaterIfNeeded(showErrorToUser: Bool) -> Bool {
        guard !hasStartedUpdater else {
            refreshUpdaterAvailability()
            return true
        }
        
        do {
            try updaterController.updater.start()
            hasStartedUpdater = true
            refreshUpdaterAvailability()
            
            DispatchQueue.main.async { [weak self] in
                self?.refreshUpdaterAvailability()
            }
            
            return true
        } catch {
            let nsError = error as NSError
            
            NSLog("Sparkle updater failed to start: %@", nsError.localizedDescription)
            canCheckForUpdates = true
            
            if showErrorToUser {
                presentUpdaterStartError(nsError)
            }
            
            return false
        }
    }
    
    private func presentUpdaterStartError(_ error: NSError?) {
        let alert = NSAlert()
        alert.alertStyle = .warning
        alert.messageText = "Unable to Check For Updates"
        alert.informativeText = error?.localizedDescription ?? "The updater failed to start."
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    private func refreshUpdaterAvailability() {
        guard hasStartedUpdater else {
            canCheckForUpdates = true
            return
        }
        
        canCheckForUpdates = updaterController.updater.canCheckForUpdates
    }
    
    private static func makeCurrentVersionString() -> String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
        return "\(version) (\(build))"
    }
}
