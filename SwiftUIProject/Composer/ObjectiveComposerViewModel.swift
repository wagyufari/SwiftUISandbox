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
    @Published var weight:Float = 0
    
    @Published var name:String = "Alter chemical composition of biofuel orders"
    @Published var description:String = "Sending out analytics can be a real burden -- we don't want to transmit non-critical data when more important information is being processed, so we have a priority scheduler in place. "
    
}
