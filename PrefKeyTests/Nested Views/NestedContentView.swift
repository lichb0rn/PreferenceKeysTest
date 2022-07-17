//
//  NestedContentView.swift
//  PrefKeyTests
//
//  Created by Miroslav Taleiko on 25.06.2022.
//

import SwiftUI

struct NestedContentView: View {
    
    @State private var fieldValues = Array<String>(repeating: "", count: 5)
    @State private var length: Float = 360
    @State private var twitterFieldPreset = false
    
    var body: some View {
        VStack(content: {
        
            Spacer()
            
            HStack(alignment: .center) {
                
                // This view puts a gray rectangle where the minimap elements will be.
                // We will reference its size and position later, to make sure the mini map elements
                // are overlayed right on top of it.
                Color(white: 0.7)
                    .frame(width: 200)
                    .anchorPreference(key: NestedPreference.self, value: .bounds) {
                        return [NestedPreferenceData(vtype: .miniMapArea, bounds: $0)]
                    }
                    .padding(.horizontal, 30)
                
                // Form Container
                VStack(alignment: .leading) {
                    // Title
                    VStack {
                        Text("Hello \(fieldValues[0]) \(fieldValues[1]) \(fieldValues[2])")
                            .font(.title).fontWeight(.bold)
                            .anchorPreference(key: NestedPreference.self, value: .bounds) {
                                return [NestedPreferenceData.init(vtype: .title, bounds: $0)]
                            }
                        Divider()
                    }
                    
                    // Switch + Slider
                    HStack {
                        Toggle(isOn: $twitterFieldPreset) { Text("") }
                        
                        Slider(value: $length, in: 360...540).layoutPriority(1)
                    }.padding(.bottom, 5)
                    
                    // First row of text fields
                    HStack {
                        NestedFormField(fieldValue: $fieldValues[0], label: "First Name")
                        NestedFormField(fieldValue: $fieldValues[1], label: "Middle Name")
                        NestedFormField(fieldValue: $fieldValues[2], label: "Last Name")
                    }.frame(width: 540)
                    
                    // Second row of text fields
                    HStack {
                        NestedFormField(fieldValue: $fieldValues[3], label: "Email")
                        
                        if twitterFieldPreset {
                            NestedFormField(fieldValue: $fieldValues[4], label: "Twitter")
                        }
                        
                        
                    }.frame(width: CGFloat(length))
                    
                }.transformAnchorPreference(key: NestedPreference.self, value: .bounds) {
                    $0.append(NestedPreferenceData(vtype: .formContainer, bounds: $1))
                }
                
                Spacer()
                
            }
            .overlayPreferenceValue(NestedPreference.self) { preferences in
                GeometryReader { geometry in
                    MiniMap(geometry: geometry, preferences: preferences)
                }
            }
            
            Spacer()
        }).background(Color(white: 0.8)).edgesIgnoringSafeArea(.all)
    }
}


//struct NestedContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        NestedContentView()
//    }
//}
