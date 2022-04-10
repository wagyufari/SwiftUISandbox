//
//  Binding+Extension.swift
//  SwiftUIProject
//
//  Created by Muhammad Ghifari on 09/04/22.
//

import Foundation
import SwiftUI


public extension Binding where Value: Equatable {
    init(_ source: Binding<Value?>, replacingNilWith nilProxy: Value) {
        self.init(
            get: { source.wrappedValue ?? nilProxy },
            set: { newValue in
                if newValue == nilProxy {
                    source.wrappedValue = nil
                }
                else {
                    source.wrappedValue = newValue
                }
        })
    }
}
