//
//  ContentView.swift
//  SwiftUIProject
//
//  Created by Muhammad Ghifari on 05/04/22.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    
    @State var isWeightComposerShown = false
    @State var frame:CGSize = .zero
    
    var body: some View{
        return ZStack{
            ObjectiveComposerView()
        }
    }
    
    func makeView(_ geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            if frame.height == 0{
                self.frame = geometry.size
            }
        }
        return Text("")
    }
    
}

