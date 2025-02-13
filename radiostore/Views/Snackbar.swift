//
//  Snackbar.swift
//  radiostore
//
//  Created by adham khwaldeh on 16/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation
import SwiftUI

struct Snackbar: View {

    @Binding var isShowing: Bool

    private let presenting: AnyView

    private let text: Text

    private let actionText: Text?

    private let action: (() -> Void)?

    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    private var isBeingDismissedByAction: Bool {
        actionText != nil && action != nil
    }

    init<Presenting>(isShowing: Binding<Bool>,
                     presenting: Presenting,
                     text: Text,
                     actionText: Text? = nil,
                     action: (() -> Void)? = nil) where Presenting: View {

        self._isShowing = isShowing
        self.presenting = AnyView(presenting)
        self.text = text
        self.actionText = actionText
        self.action = action

    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.presenting
                VStack {
                    Spacer()
                    if self.isShowing {
                        HStack {
                            self.text.foregroundColor(self.colorScheme == .light ? .white : .black)
                            Spacer()
                            if (self.actionText != nil && self.action != nil) {
                                self.actionText!
                                    .bold()
                                    .foregroundColor(self.colorScheme == .light ? .white : .black)
                                    .onTapGesture {
                                    self.action?()
                                    withAnimation {
                                        self.isShowing = false
                                    }
                                }
                            }
                        }
                            .padding()
                            .frame(width: geometry.size.width * 0.9, height: 50)
                            .shadow(radius: 3)
                            .background(self.colorScheme == .light ? Color.black : Color.white)
                            .offset(x: 0, y: -20)
                            .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .trailing)))
                            .animation(Animation.spring())
                            .onAppear {
                            guard !self.isBeingDismissedByAction else { return }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    self.isShowing = false
                                }
                            }
                        }
                    }
                }
            }
        }
    }

}
