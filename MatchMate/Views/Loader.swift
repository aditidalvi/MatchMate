//
//  Loader.swift
//  MatchMate
//
//  Created by Abcom on 13/02/25.
//

import SwiftUI

struct ThreeDotsLoader: View {
    @State private var animation = false

    var body: some View {
        VStack {
            Text("Hang tight, your perfect match is on the way!")
                .fontWeight(.medium)
            HStack(spacing: 5) {
                Circle()
                    .frame(width: 10, height: 10)
                    .scaleEffect(animation ? 1 : 0.5)
                    .animation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.0), value: animation)
                
                Circle()
                    .frame(width: 10, height: 10)
                    .scaleEffect(animation ? 1 : 0.5)
                    .animation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.2), value: animation)
                
                Circle()
                    .frame(width: 10, height: 10)
                    .scaleEffect(animation ? 1 : 0.5)
                    .animation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.4), value: animation)
            }
            .onAppear {
                self.animation.toggle()
            }
        }
    }
}

#Preview {
    ThreeDotsLoader()
}
