//
//  ContentView.swift
//  NFC Read-Write
//
//  Created by Ming on 1/1/2023.
//

import SwiftUI
import SwiftNFC

struct ContentView: View {
    // MARK: - NFC Components
    @ObservedObject var nfcReader = NFCReader()
    @ObservedObject var nfcWriter = NFCWriter()
    
    // MARK: - UI State
    @State private var keyboardVisible: Bool = false
    
    var body: some View {
        DraggableInterfaceView {
            // Top Content - Message Editor
            if #available(iOS 16.0, *) {
                NFCMessageEditor(nfcReader: nfcReader)
                    .scrollContentBackground(.hidden)
            } else {
                NFCMessageEditor(nfcReader: nfcReader)
            }
        } bottomContent: {
            // Bottom Content - Raw Data Editor + Actions
            VStack(spacing: 0) {
                if #available(iOS 16.0, *) {
                    NFCRawDataEditor(nfcReader: nfcReader)
                        .scrollContentBackground(.hidden)
                } else {
                    NFCRawDataEditor(nfcReader: nfcReader)
                }
                
                Divider()
                
                NFCActionView(
                    onRead: { nfcReader.read() },
                    onWrite: { 
                        nfcWriter.msg = nfcReader.msg
                        nfcWriter.write()
                    }
                )
                .frame(height: 75)
            }
        } dragContent: {
            // Drag Content - Options
            NFCOptionsView(
                nfcWriter: nfcWriter,
                keyboardVisible: $keyboardVisible
            )
        }
        .ignoresSafeArea(.all)
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            keyboardVisible = true
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            keyboardVisible = false
        }
        .onTapGesture(count: 2) {
            // Double tap to hide keyboard
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
