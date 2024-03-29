//
//  ContentView.swift
//  SwiftUIProject
//
//  Created by Muhammad Ghifari on 05/04/22.
//

import SwiftUI
import Combine
import OmenTextField

struct BaseComposerView<Content: View>: View {
    
    @ObservedObject var viewModel: ObjectiveComposerViewModel
    @ViewBuilder var content: () -> Content
    
    @FocusState var nameFocus:Bool
    @FocusState var descriptionFocus:Bool
    
    var body: some View{
        return ZStack{
            ScrollView{
                VStack{
                    HStack{
                        CheckboxFieldView(width: 24, height: 24)
                        Text("Set as Project")
                            .font(.system(size: 14))
                            .padding(.horizontal, 8)
                        Spacer()
                    }
                    HStack{
                        UserNameRoleView(role: "Reviewer")
                        UserNameRoleView(role: "Owner")
                        Spacer()
                    }.padding(.top, 20)
                    VStack{
                        MultiTextField("Objective Name", text: $viewModel.name, font: .systemFont(ofSize: 20, weight: .medium))
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.textPrimary)
                            .focused($nameFocus)
                        MultiTextField("Description", text: $viewModel.description)
                            .font(.system(size: 14))
                            .foregroundColor(.textPrimary)
                            .focused($descriptionFocus)
                    }.padding(.top, 24)
                    VStack{
                        ComposerItem(title: "Units (#)", description: "0 out of 100", descriptionColor: .textTertiary, icon: "ico-metric")
                        ComposerItem(title: "12 Dec 2019 - 13 Dec 2020", description: "This objective does not repeat", titleColor: .violet600, descriptionColor: .textSecondary, icon: "ico-calendar")
                        ComposerItem(title: viewModel.weight == 0 ? "Set Weight" : "Weight: \(viewModel.weight)%", description: "", titleColor: viewModel.weight == 0 ? .textTertiary : .violet600, descriptionColor: .red, icon: "ico-weight")
                            .onTapGesture {
                                viewModel.isWeightComposerShown.toggle()
                            }
                        ComposerItem(title: "Travel & Relocation Support", titleColor: .violet600, icon: "ico-alignment")
                        if !viewModel.labels.isEmpty{
                            ComposerItem(title:viewModel.labels.map{$0.name}.joined(separator: ", "), titleColor: .violet600, icon: "ico-label")
                                .onTapGesture {
                                    viewModel.isSelectLabelShown.toggle()
                                }
                        }
                    }.padding(.top, 24)
                    Spacer()
                }.padding(16)
            }.gesture(DragGesture().onChanged{value in
                if value.translation.height < 0{
                    nameFocus = false
                    descriptionFocus = false
                }
            })
            VStack{
                Spacer()
                Divider()
                HStack(spacing: 8){
                    HStack(spacing:28){
                        VStack(spacing:0){
                            Image("ico-alignment")
                                .renderingMode(.template)
                                .foregroundColor(.textTertiary)
                            Text("Alignment")
                                .foregroundColor(.textTertiary)
                                .font(.system(size: 12))
                        }
                        VStack(spacing:0){
                            Image("ico-label")
                                .renderingMode(.template)
                                .foregroundColor(viewModel.labels.isEmpty ? .textTertiary : .violet600)
                            Text("Label")
                                .foregroundColor(viewModel.labels.isEmpty ? .textTertiary : .violet600)
                                .font(.system(size: 12))
                        }.onTapGesture {
                            viewModel.isSelectLabelShown.toggle()
                        }
                        VStack(spacing:0){
                            Image("ico-people")
                                .renderingMode(.template)
                                .foregroundColor(.textTertiary)
                            Text("Follower")
                                .foregroundColor(.textTertiary)
                                .font(.system(size: 12))
                        }
                    }.padding(.leading, 16)
                    Spacer()
                    Text("Save")
                        .foregroundColor(.violet600)
                        .padding(.trailing, 16)
                }
                .padding(.bottom, 16)
                    .padding(.top, 8)
            }
        }
    }
}

struct ComposerItem:View{
    var title:String = ""
    var description:String = ""
    var titleColor:Color = .textPrimary
    var descriptionColor:Color = .textPrimary
    var icon:String = "ico-metric"
    
    var body: some View{
        HStack(alignment: description.isEmpty ? .center : .top){
            Image(icon)
                .renderingMode(.template)
                .foregroundColor(.neutral600)
                .frame(width: 24, height: 24)
            VStack(alignment:.leading){
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(titleColor)
                if !description.isEmpty{
                    Text(description)
                        .font(.system(size: 14))
                        .foregroundColor(descriptionColor)
                }
            }.padding(.leading, 16)
            Spacer()
            Image("ico-edit")
                .frame(width: 24, height: 24)
        }.padding(.vertical, 8).background(.white)
    }
}

struct UserNameRoleView:View{
    
    @State var role:String = "Reviewer"
    
    var body: some View{
        VStack(alignment: .leading){
            Text(role).font(.system(size: 12))
                .foregroundColor(Color.textSecondary)
            HStack{
                Image("ico-user")
                    .frame(width: 16, height: 16, alignment: .center)
                Text(role)
                    .font(.system(size: 14))
                    .foregroundColor(Color.textTertiary)
            }.padding(.vertical, 8).padding(.horizontal, 12).overlay(RoundedRectangle(cornerRadius:16).stroke(Color.neutral400, lineWidth: 0.6))
        }
    }
}
