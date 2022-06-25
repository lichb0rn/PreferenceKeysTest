//
//  ContentView.swift
//  PrefKeyTests
//
//  Created by Miroslav Taleiko on 25.06.2022.
//

import SwiftUI

struct ContentView : View {
    
    @State private var activeIdx: Int = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                MonthView(activeMonth: $activeIdx, label: "January", idx: 0)
                MonthView(activeMonth: $activeIdx, label: "February", idx: 1)
                MonthView(activeMonth: $activeIdx, label: "March", idx: 2)
                MonthView(activeMonth: $activeIdx, label: "April", idx: 3)
            }
            
            Spacer()
            
            HStack {
                MonthView(activeMonth: $activeIdx, label: "May", idx: 4)
                MonthView(activeMonth: $activeIdx, label: "June", idx: 5)
                MonthView(activeMonth: $activeIdx, label: "July", idx: 6)
                MonthView(activeMonth: $activeIdx, label: "August", idx: 7)
            }
            
            Spacer()
            
            HStack {
                MonthView(activeMonth: $activeIdx, label: "September", idx: 8)
                MonthView(activeMonth: $activeIdx, label: "October", idx: 9)
                MonthView(activeMonth: $activeIdx, label: "November", idx: 10)
                MonthView(activeMonth: $activeIdx, label: "December", idx: 11)
            }
            
            Spacer()
        }.backgroundPreferenceValue(MyTextPrefernceKey.self) { preferences in
            GeometryReader { geometry in
                self.createBorder(geometry, preferences)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
    
    func createBorder(_ geometry: GeometryProxy, _ preferences: [MyTextPreferenceData]) -> some View {
        let p = preferences.first(where: { $0.viewIdx == self.activeIdx })
        
        let aTopLeading = p?.topLeading
        let aBottomTrailing = p?.bottomTrailing
        
        let topLeading = aTopLeading != nil ? geometry[aTopLeading!] : .zero
        let bottomTrailing = aBottomTrailing != nil ? geometry[aBottomTrailing!] : .zero
        
        
        return RoundedRectangle(cornerRadius: 15)
            .stroke(lineWidth: 3.0)
            .foregroundColor(Color.green)
            .frame(width: bottomTrailing.x - topLeading.x, height: bottomTrailing.y - topLeading.y)
            .fixedSize()
            .offset(x: topLeading.x, y: topLeading.y)
            .animation(.easeInOut(duration: 1.0))
    }
}

struct MonthView: View {
    @Binding var activeMonth: Int
    let label: String
    let idx: Int
    
    var body: some View {
        Text(label)
            .padding(10)
            .anchorPreference(key: MyTextPrefernceKey.self, value: .topLeading, transform: { [MyTextPreferenceData(viewIdx: self.idx, topLeading: $0)] })
            .transformAnchorPreference(key: MyTextPrefernceKey.self, value: .bottomTrailing, transform: { ( value: inout [MyTextPreferenceData], anchor: Anchor<CGPoint>) in
                value[0].bottomTrailing = anchor
            })
            
            .onTapGesture { self.activeMonth = self.idx }
    }
}

//
//struct MyPreferenceViewSetter: View {
//    let idx: Int
//
//    var body: some View {
//        GeometryReader { geometry in
//            Rectangle()
//                .fill(Color.clear)
//                .preference(value: [MyTextPreferenceData(viewIndex: idx, bounds: geometry.frame)])
////                .preference(key: MyTextPrefernceKey.self,
////                            value: [MyTextPreferenceData(viewIndex: idx,
////                                                         rect: geometry.frame(in: .named("myZStack")))])
//        }
//    }
//}

struct MonthBorder: View {
    let show: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .stroke(lineWidth: 3.0).foregroundColor(show ? Color.red : Color.clear)
            .animation(.easeInOut(duration: 0.6))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
