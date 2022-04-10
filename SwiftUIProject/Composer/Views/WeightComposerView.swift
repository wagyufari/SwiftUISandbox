//
//  ContentView.swift
//  SwiftUIProject
//
//  Created by Muhammad Ghifari on 05/04/22.
//

import SwiftUI
import Combine

struct WeightComposerView<Content: View>: View {
    
    @State var weightString = ""
    @FocusState private var inputFocus:Bool
    

    @ObservedObject var viewModel: ObjectiveComposerViewModel
    @ViewBuilder var content: ()->Content
    
    @State var weight:Float = 0
    
    @State private var totalHeight: CGFloat = 0
    @State var isFirstRun = true
    
    var body: some View{
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = 0
        
        DispatchQueue.main.async {
            if isFirstRun{
                weight = viewModel.weight
                isFirstRun = false
            }
        }
        
        return GeometryReader{ geo in
            VStack(alignment:.leading, spacing: 8){
                HStack{
                    Spacer()
                    Rectangle()
                        .fill(Color.neutral400)
                        .frame(width: 36, height: 4, alignment: .center)
                        .cornerRadius(4)
                    Spacer()
                }.padding()
                HStack{
                    Image(uiImage: UIImage(named: "ico-weight")!)
                        .frame(width: 24, height: 24)
                    Text("Set Weight")
                        .font(.system(size: 16))
                        .foregroundColor(.textPrimary)
                        .padding(.leading, 16)
                    Spacer()
                    HStack{
                        Spacer()
                        TextField("0", value: $weight, formatter: formatter)
                            .multilineTextAlignment(.center)
                            .keyboardType(.decimalPad)
                            .padding(0)
                            .foregroundColor(.black)
                            .modifier(WeightTextFieldModifier(value: $weight))
                            .focused($inputFocus)
                        Text("%")
                            .padding(0)
                            .foregroundColor(.black)
                        Spacer()
                    }.onTapGesture {
                        inputFocus = true
                    }
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.neutral400, lineWidth: 1).frame(width: 70, height: 36))
                    .frame(width: 70, height: 36)
                }.padding(.top, 8).padding(.horizontal, 16)
                Slider(value: $weight, in: 0...100, step: 1){ editing in
                    if editing{
                        inputFocus = false
                    }
                }
                .tint(.violet600)
                .padding(.leading, 56)
                .padding(.trailing, 16)
                Text("Minimum weight for each objective 15% and maximum 35%")
                    .font(.system(size: 14))
                    .padding(.leading, 56)
                    .padding(.trailing, 16)
                    .foregroundColor(.textTertiary)
                
                HStack{
                    VStack(alignment:.leading){
                        Text("Total weight")
                            .bold()
                            .foregroundColor(.textPrimary)
                            .font(.system(size: 16))
                        Text("Accumulated with 4 other top parent objective(s)")
                            .font(.system(size: 16))
                            .foregroundColor(.textSecondary)
                        Text("100%")
                            .bold()
                            .font(.system(size: 24))
                            .foregroundColor(.textPrimary)
                            .onTapGesture {
                                inputFocus = false
                            }
                            .padding(.top, 16)
                    }.padding(12)
                        .background(Color.blue100)
                        .cornerRadius(4)
                }.padding(16)
                VStack(alignment:.trailing){
                    Divider().padding(.top, 48)
                    Text("ADD WEIGHT")
                        .foregroundColor(.violet600)
                        .font(.system(size: 16, weight: .medium))
                        .padding(.top, 16)
                        .padding(.trailing, 24)
                        .padding(.bottom, 24)
                        .onTapGesture {
                            self.viewModel.weight = weight
                            self.viewModel.isWeightComposerShown = false
                        }
                }
            }.background(ViewGeometry()).onPreferenceChange(ViewHeightKey.self){
                viewModel.weightComposerFrame = $0
            }
            .background(Color.white)
        }
    }
}

struct ViewGeometry: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ViewHeightKey.self, value: geometry.size.height)
        }
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

//return ZStack{
//    GeometryReader{ geometry in
////                DispatchQueue.main.async {
////                    if viewModel.weightComposerFrame == 0{
////                        viewModel.weightComposerFrame = geometry.size.height
////                    }
////
//    }
//}

struct WeightTextFieldModifier:ViewModifier{
    @Binding var value:Float
    
    func body(content: Content) -> some View {
        return content.onChange(of: $value.wrappedValue) { newValue in
        }
        //        content.onReceive(value.publisher.collect()){
        //            if let floatValue = Float(value){
        //                if floatValue > 100{
        //                    value = "100"
        //                } else{
        //                    if value.count > 1, value.first == "0"{
        //                       var newValue = value
        //                        newValue.remove(at: newValue.startIndex)
        //                        value = newValue
        //                    } else{
        //                        value = String($0)
        //                    }
        //                }
        //            } else{
        //                value = String("0")
        //            }
        //        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeightComposerView()
//    }
//}
