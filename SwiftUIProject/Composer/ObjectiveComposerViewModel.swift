//
//  ObjectiveComposerViewModel.swift
//  SwiftUIProject
//
//  Created by Muhammad Ghifari on 09/04/22.
//

import Foundation
import SwiftUI

class ObjectiveComposerViewModel: ObservableObject {
    @Published var weightComposerFrame:CGFloat = .zero
    @Published var isWeightComposerShown:Bool = false
    @Published var isSelectLabelShown:Bool = false
    
    @Published var name:String = ""
    @Published var description:String = ""
    
    @Published var weight:Float = 0
    @Published var labels:[Label] = []
    
}
