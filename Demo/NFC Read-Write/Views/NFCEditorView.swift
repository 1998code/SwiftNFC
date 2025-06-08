//
//  NFCEditorView.swift
//  NFC Read-Write
//
//  Created by Ming on 6/8/2025.
//

import SwiftUI
import SwiftNFC

struct NFCEditorView: View {
    @Binding var text: String
    let placeholder: String
    var font: Font = .body
    
    var body: some View {
        TextEditor(text: $text)
            .font(font)
            .padding(15)
    }
}

struct NFCMessageEditor: View {
    @ObservedObject var nfcReader: NFCReader
    
    var body: some View {
        NFCEditorView(text: $nfcReader.msg, placeholder: "Scan to read or Edit here to write...", font: .title)
    }
}

struct NFCRawDataEditor: View {
    @ObservedObject var nfcReader: NFCReader
    
    var body: some View {
        NFCEditorView(text: $nfcReader.raw, placeholder: "Raw Data available after scan.")
    }
}

#Preview {
    NFCEditorView(text: .constant("Sample text"), placeholder: "Enter text here...")
}
