//
//  ContentView.swift
//  NFC Read-Write
//
//  Created by Ming on 1/1/2023.
//

import SwiftUI
import SwiftNFC

struct ContentView: View {
    // MARK: - You can use either Reader / Writer or both in your application.
    @ObservedObject var NFCR = NFCReader()
    @ObservedObject var NFCW = NFCWriter()
    
    // MARK: - Editor for I/O Message
    var editor: some View {
        TextEditor(text: $NFCR.msg)
            .font(.title)
            .padding(.top, 50)
            .padding(15)
            .background(Color.accentColor.opacity(0.5))
    }
    // MARK: - Show Read Message Raw Data
    var editorRaw: some View {
        TextEditor(text: $NFCR.raw)
            .padding(15)
            .background(Color.red.opacity(0.5))
    }
    
    // MARK: - Detect whether the keyboard shown on screen or not.
    @State var keyboard: Bool = false
    
    // MARK: - Main App Content
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                if #available(iOS 16.0, *) {
                    editor
                        .scrollContentBackground(.hidden)
                    option
                    editorRaw
                        .scrollContentBackground(.hidden)
                } else {
                    // Fallback on earlier versions
                    editor
                    option
                    editorRaw
                }
            }
            action
                .frame(height: 75)
        }
        .ignoresSafeArea(.all)
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            keyboard = true
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            keyboard = false
        }
        .onTapGesture(count: 2) {
            // MARK: Double Tap anywhere can hide the keyboard
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    // MARK: - Select NFC Option(s)
    var option: some View {
        HStack {
            Picker(selection: $NFCW.type, label: Text("Type Picker")) {
                Text("Text").tag("T")
                Text("Link").tag("U")
            }
            Spacer()
            if keyboard {
                Button(action: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Close Keyboard")
                }
            }
        }.padding(.horizontal)
    }
    
    // MARK: - Action Buttons
    var action: some View {
        HStack(spacing: 0) {
            Button (action: { read() }) {
                ZStack {
                    Color.pink.opacity(0.85)
                    Label("Read NFC", systemImage: "wave.3.left.circle.fill")
                        .foregroundColor(.white)
                        .padding(.top, 15)
                        .padding(.bottom, 35)
                }
            }
            Button (action: { write() }) {
                ZStack {
                    Color.accentColor.opacity(0.85)
                    Label("Write NFC", systemImage: "wave.3.left.circle.fill")
                        .foregroundColor(.white)
                        .padding(.top, 15)
                        .padding(.bottom, 35)
                }
            }
        }
    }
    
    // MARK: - Sample I/O Functions
    func read() {
        NFCR.read()
    }
    func write() {
        NFCW.msg = NFCR.msg
        NFCW.write()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
