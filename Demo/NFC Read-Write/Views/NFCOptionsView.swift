//
//  NFCOptionsView.swift
//  NFC Read-Write
//
//  Created by Ming on 6/8/2025.
//

import SwiftUI
import SwiftNFC

struct NFCOptionsView: View {
    @ObservedObject var nfcWriter: NFCWriter
    @AppStorage("type") private var type = "T"
    @Binding var keyboardVisible: Bool
    @State private var animationOffset: CGFloat = 0
    
    var body: some View {
        HStack {
            Text("SwiftNFC")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.accentColor.opacity(0.8),
                            Color.white.opacity(0.8),
                            Color.red.opacity(0.8),
                        ]),
                        startPoint: UnitPoint(x: animationOffset - 0.3, y: 0.5),
                        endPoint: UnitPoint(x: animationOffset + 0.3, y: 0.5)
                    )
                )
                .onAppear {
                    startShimmerAnimation()
                }

            Spacer()

            if keyboardVisible {
                Button(action: {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Image(systemName: "keyboard.chevron.compact.down")
                }.tint(.secondary)
            }

            Spacer()

            Picker(selection: $type, label: Text("Type Picker")) {
                Text("Text").tag("T")
                Text("Link").tag("U")
            }
            .onAppear {
                nfcWriter.type = type
            }
            .onChange(of: type) { newType in
                nfcWriter.type = newType
            }
        }
        .padding(.horizontal, 20)
    }
    
    private func startShimmerAnimation() {
        withAnimation(
            Animation.linear(duration: 2.0)
                .repeatForever(autoreverses: false)
        ) {
            animationOffset = 1.3
        }
    }
}

#Preview {
    NFCOptionsView(
        nfcWriter: NFCWriter(),
        keyboardVisible: .constant(true)
    ).preferredColorScheme(.dark)
}
