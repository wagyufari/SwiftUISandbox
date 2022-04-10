//
//  BaseView.swift
//  SwiftUIProject
//
//  Created by Muhammad Ghifari on 09/04/22.
//

import Foundation
import SwiftUI

struct BaseView<Content:View>:View{
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {content}
}
