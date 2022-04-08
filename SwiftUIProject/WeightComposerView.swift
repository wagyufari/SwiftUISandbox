//
//  ContentView.swift
//  SwiftUIProject
//
//  Created by Muhammad Ghifari on 05/04/22.
//

import SwiftUI
import Combine

struct WeightComposerView: View {
    
    @State var weight:Float = 0.0
    @State var weightString = ""
    @FocusState private var inputFocus:Bool
    
    var body: some View{
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = 0

        return VStack(alignment:.leading, spacing: 16){
            HStack{
                Spacer()
                Rectangle()
                    .fill(Color.neutral400)
                    .frame(width: 36, height: 4, alignment: .center)
                    .cornerRadius(4)
                Spacer()
            }
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
                    TextField("0", text: $weightString)
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                        .padding(0)
                        .modifier(WeightTextFieldModifier(value: $weightString))
                        .focused($inputFocus)
                    Text("%")
                        .padding(0)
                    Spacer()
                }.onTapGesture {
                    inputFocus = true
                }
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.neutral400, lineWidth: 1).frame(width: 70, height: 36))
                .frame(width: 70, height: 36)
            }.padding(.top, 8).padding(.horizontal, 16)
            Slider(value: $weight, in: 0...100){ editing in
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
                VStack{
                    HStack{
                        Text("Total weight")
                            .bold()
                            .foregroundColor(.textPrimary)
                            .font(.system(size: 16))
                        Spacer()
                    }
                    HStack{
                        Text("Accumulated with 4 other top parent objective(s)")
                            .font(.system(size: 16))
                            .foregroundColor(.textSecondary)
                        Spacer()
                    }
                    HStack{
                        Text("100%")
                            .bold()
                            .font(.system(size: 24))
                            .foregroundColor(.textPrimary)
                            .onTapGesture {
                                inputFocus = false
                            }
                        Spacer()
                    }.padding(.top, 16)
                }.padding(12)
                 .background(Color.blue100)
                 .cornerRadius(4)
            }.padding(16)
            Spacer()
        }
    }
}

struct WeightTextFieldModifier:ViewModifier{
    @Binding var value:String
    
    func body(content: Content) -> some View {
        content.onReceive(value.publisher.collect()){
            if let floatValue = Float(value){
                if floatValue > 100{
                    value = "100"
                } else{
                    if value.count > 1, value.first == "0"{
                       var newValue = value
                        newValue.remove(at: newValue.startIndex)
                        value = newValue
                    } else{
                        value = String($0)
                    }
                }
            } else{
                value = String("0")
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeightComposerView()
//    }
//}
