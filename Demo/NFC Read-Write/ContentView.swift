//
//  ContentView.swift
//  NFC Read-Write
//
//  Created by Ming on 1/1/2023.
//

import SwiftUI
import SwiftNFC

struct ContentView: View {
    @ObservedObject var NFCR = NFCReader()
    @ObservedObject var NFCW = NFCWriter()
    
    var editor: some View {
        TextEditor(text: $NFCR.msg)
            .font(.title)
            .padding(.top, 50)
            .padding(15)
            .background(Color.accentColor.opacity(0.5))
    }
    var editorRaw: some View {
        TextEditor(text: $NFCR.raw)
            .padding(15)
            .background(Color.red.opacity(0.5))
    }
    
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
        .onTapGesture(count: 2) {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    var option: some View {
        HStack {
            Picker(selection: $NFCW.type, label: Text("Type Picker")) {
                Text("Text").tag("T")
                Text("Link").tag("U")
            }
            Spacer()
            Button(action: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }) {
                Text("Close Keyboard")
            }
        }.padding(.horizontal)
    }
    
    var action: some View {
        HStack(spacing: 0) {
            Button (action: { read() }) {
                ZStack {
                    Color.blue.opacity(0.85)
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
