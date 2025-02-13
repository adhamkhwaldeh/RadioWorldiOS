//
//  CountDownTimer.swift
//  radiostore
//
//  Created by adham khwaldeh on 16/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation
import SwiftUI

class CountDownTimer: ObservableObject {

    @Published var counter: CGFloat = 10

    let interval = 1.0

    var timer: Timer?

    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { _ in
            self.counter -= 1
            print(self.counter)

            if self.counter <= 0 {
                self.timer?.invalidate()
                self.timer = nil
            }
        })
    }

    func stop() {
        self.timer?.invalidate()
    }
}
