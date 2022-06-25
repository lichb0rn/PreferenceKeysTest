//
//  ContentView.swift
//  PrefKeyTests
//
//  Created by Miroslav Taleiko on 25.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var activeIdx: Int = 0
    @State private var rects: [CGRect] = Array<CGRect>(repeating: CGRect(), count: 12)
       
       var body: some View {
           ZStack(alignment: .topLeading) {
               RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 3.0).foregroundColor(Color.green)
                   .frame(width: rects[activeIdx].size.width, height: rects[activeIdx].size.height)
                   .offset(x: rects[activeIdx].minX, y: rects[activeIdx].minY)
                   .animation(.easeInOut(duration: 1.0))
               
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
               }
               .onPreferenceChange(MyTextPrefernceKey.self) { preferences  in
                   for p in preferences {
                       self.rects[p.viewIndex] = p.rect
                   }
               }
           }.coordinateSpace(name: "myZStack")
       }
}

struct MonthView: View {
    @Binding var activeMonth: Int
    let label: String
    let idx: Int
    
    var body: some View {
        Text(label)
            .padding(10)
            .onTapGesture { self.activeMonth = self.idx }
            .background(MyPreferenceViewSetter(idx: idx)).onTapGesture {
                self.activeMonth = self.idx
            }
    }
}

struct MyPreferenceViewSetter: View {
    let idx: Int
    
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(key: MyTextPrefernceKey.self,
                            value: [MyTextPreferenceData(viewIndex: idx,
                                                         rect: geometry.frame(in: .named("myZStack")))])
        }
    }
}

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
