//
//  SearchView.swift
//  SwiftUIProject
//
//  Created by Muhammad Ghifari on 10/04/22.
//

import Foundation
import SwiftUI

struct SearchView:View{
    
    @Binding var text:String
    var placeholder:String = ""
    @FocusState var focus:Bool
    
    var body: some View{
        HStack{
            HStack{
                HStack{
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("", text: $text)
                        .focused($focus)
                        .placeholder(when: text.isEmpty) {
                            Text(placeholder).foregroundColor(.gray)
                        }.foregroundColor(.textPrimary)
                    if !text.isEmpty{
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .onTapGesture {
                                text = ""
                            }
                    }
                }.padding(10)
            }.background(Color.search)
                .cornerRadius(8)
            if focus{
                Text("Cancel")
                    .foregroundColor(.violet600)
                    .onTapGesture {
                        focus = false
                    }
            }
        }
    }
}
