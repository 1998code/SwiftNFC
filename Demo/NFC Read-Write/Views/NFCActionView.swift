//
//  NFCActionView.swift
//  NFC Read-Write
//
//  Created by Ming on 6/8/2025.
//

import SwiftUI
import SwiftNFC

struct NFCActionView: View {
    let onRead: () -> Void
    let onWrite: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: onRead) {
                Spacer()
                Label("Read NFC", systemImage: "wave.3.left.circle.fill")
                Spacer()
            }
            .tint(.white)
            
            Divider()
            
            Button(action: onWrite) {
                Spacer()
                Label("Write NFC", systemImage: "wave.3.left.circle.fill")
                Spacer()
            }
            .tint(.white)
        }
    }
}

#Preview {
    NFCActionView(
        onRead: { print("Read tapped") },
        onWrite: { print("Write tapped") }
    )
    .frame(height: 75)
    .background(Color.gray.opacity(0.2))
}
