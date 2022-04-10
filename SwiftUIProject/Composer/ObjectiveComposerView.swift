//
//  ContentView.swift
//  SwiftUIProject
//
//  Created by Muhammad Ghifari on 05/04/22.
//

import SwiftUI
import Combine

struct ObjectiveComposerView: View {
    
    @StateObject var viewModel = ObjectiveComposerViewModel()
    
    var body: some View{
        return ZStack{
            BaseComposerView(viewModel: viewModel) {
                
            }
            WeightComposerView(viewModel: viewModel) {
                
            }.modifier(BottomSheetResizedModifier(isShown: $viewModel.isWeightComposerShown, frame: $viewModel.weightComposerFrame))
        }
    }
}

