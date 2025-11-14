//
//  NFC_Read_WriteApp.swift
//  NFC Read-Write
//
//  Created by Ming on 1/1/2023.
//

import SwiftUI

@main
struct NFC_Read_WriteApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .statusBarHidden(true)
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb else {
            return false
        }

        // Confirm that the NSUserActivity object contains a valid NDEF message.
        let ndefMessage = userActivity.ndefMessagePayload
        guard !ndefMessage.records.isEmpty,
            ndefMessage.records[0].typeNameFormat != .empty else {
                return false
        }

        return true
    }
}
