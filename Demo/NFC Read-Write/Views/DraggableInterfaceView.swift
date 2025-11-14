//
//  DraggableInterfaceView.swift
//  NFC Read-Write
//
//  Created by Ming on 6/8/2025.
//

import SwiftUI

struct DraggableInterfaceView<TopContent: View, BottomContent: View, DragContent: View>: View {
    let topContent: TopContent
    let bottomContent: BottomContent
    let dragContent: DragContent

    @State private var topHeight: CGFloat = 0
    @State private var isDragging = false
    @State private var topSafeArea: CGFloat = 0
    
    init(
        @ViewBuilder topContent: () -> TopContent,
        @ViewBuilder bottomContent: () -> BottomContent,
        @ViewBuilder dragContent: () -> DragContent
    ) {
        self.topContent = topContent()
        self.bottomContent = bottomContent()
        self.dragContent = dragContent()
    }
    
    var body: some View {
        GeometryReader { geometry in
            let initialHeight = geometry.size.height / 2

            VStack(spacing: 0) {
                // Top section
                VStack {
                    topContent
                        .padding(.top, topSafeArea)
                }
                .frame(height: topHeight)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.accentColor.opacity(0.35), Color.clear]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
                // Draggable divider
                VStack {
                    Rectangle()
                        .fill(isDragging ? Color.primary : Color.gray.opacity(0.25))
                        .frame(width: 75, height: 4)
                        .cornerRadius(25)
                    
                    dragContent
                        .padding(.top, 4)
                }
                .frame(height: 60)
                .padding(.vertical, 5)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isDragging = true
                            let newHeight = topHeight + value.translation.height
                            let minHeight: CGFloat = 150
                            let maxHeight = geometry.size.height - 200 - 60
                            topHeight = max(minHeight, min(maxHeight, newHeight))
                        }
                        .onEnded { _ in
                            isDragging = false
                        }
                )
                
                // Bottom section
                VStack(spacing: 0) {
                    bottomContent
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.clear, Color.red.opacity(0.35)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .onAppear {
                if topHeight == 0 {
                    topHeight = initialHeight
                }
                if topSafeArea == 0 {
                    topSafeArea = UIApplication.shared.connectedScenes
                        .compactMap { $0 as? UIWindowScene }
                        .first?.windows
                        .first?.safeAreaInsets.top ?? 0
                }
            }
        }
    }
}

#Preview {
    DraggableInterfaceView {
        Text("Top Content")
            .font(.title)
            .padding()
    } bottomContent: {
        Text("Bottom Content")
            .font(.title)
            .padding()
    } dragContent: {
        Text("Drag Options")
            .font(.caption)
    }
    .ignoresSafeArea(.all)
    .preferredColorScheme(.dark)
}
