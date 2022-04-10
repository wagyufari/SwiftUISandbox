//
//  ContentView.swift
//  SwiftUIProject
//
//  Created by Muhammad Ghifari on 05/04/22.
//

import SwiftUI
import Combine


struct SelectLabelView<Content: View>: View {
    
    @State var weightString = ""
    @FocusState private var inputFocus:Bool
    
    @ObservedObject var viewModel: ObjectiveComposerViewModel
    @ViewBuilder var content: ()->Content
    @State var weight:Float = 0
    
    @State var query:String = ""
    @State private var selection: String? = nil
    
    let columns = [
        GridItem(.adaptive(minimum: 42), alignment: .leading)
    ]
    let data = ["Expansion", "Label 2"]
    
    @State var labels = [Label(name: "Ninetendo"),
                         Label(name: "XBox"),
                         Label(name: "PlayStation"),
                         Label(name: "PlayStation 2"),
                         Label(name: "PlayStation 3"),
                         Label(name: "PlayStation 4")]
    @State var selectedLabels: [Label] = []
    
    @State var isFirstRun = true
    
    var body: some View{
        
        DispatchQueue.main.async {
            if isFirstRun{
                selectedLabels = viewModel.labels
                isFirstRun = false
            }
        }
        
        return VStack(alignment:.leading, spacing:0){
            ZStack{
                Text("Add Label")
                    .foregroundColor(.textPrimary)
                HStack{
                    Image("ico-close")
                        .foregroundColor(.icon)
                        .frame(width: 24, height: 24)
                    Spacer()
                    Text("ADD LABEL")
                        .foregroundColor(.violet600)
                        .onTapGesture {
                            viewModel.labels = selectedLabels
                            viewModel.isSelectLabelShown.toggle()
                        }
                }
            }
            .padding()
            .background(Color.navigation)
            Divider()
            SearchView(text: $query, placeholder: "Create Label").padding()
            if !query.isEmpty{
                LabelItem(title: query, isSelected: selectedLabels.contains(Label(name: query))) {
                    if selectedLabels.contains(Label(name: query)){
                        selectedLabels.removeAll(where: {$0.name == query})
                    } else{
                        selectedLabels.append(Label(name: query))
                    }
                }.padding(.horizontal, 14)
            } else{
                FlexBox<Label, LabelItem>(array: $labels) { item in
                    LabelItem(title: item.name, isSelected: selectedLabels.contains(item)){
                        if selectedLabels.contains(item){
                            selectedLabels.removeAll(where: {$0.name == item.name})
                        } else{
                            selectedLabels.append(item)
                        }
                    }
                }.padding(.horizontal, 12)
            }
            Spacer()
            if !selectedLabels.isEmpty{
                Divider()
                ScrollView(.horizontal){
                    HStack{
                        ForEach(selectedLabels.reversed(), id: \.self){ item in
                            LabelItem(title: item.name, isSelected: selectedLabels.contains(item)){
                                if selectedLabels.contains(item){
                                    selectedLabels.removeAll(where: {$0.name == item.name})
                                } else{
                                    selectedLabels.append(item)
                                }
                            }
                        }
                    }.padding(.bottom, 48)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                }
            }
        }.background(.white)
    }
    
    struct LabelItem:View{
        var title:String
        var isSelected:Bool
        var onTap: ()->Void
        
        var body: some View{
            VStack{
                HStack(spacing:4){
                    Image(systemName: isSelected ? "xmark.circle.fill" : "plus.circle.fill")
                        .foregroundColor(isSelected ? .red : .violet600)
                        .frame(width: 24, height: 24)
                    Text(title)
                        .font(.system(size: 14))
                        .foregroundColor(.textPrimary)
                }.padding(.trailing, 8)
                    .padding(.leading, 4)
                    .padding(.vertical, 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 32)
                            .stroke(Color.neutral400, lineWidth: 1)).onTapGesture {
                                onTap()
                            }
            }
        }
    }
    
    
}
