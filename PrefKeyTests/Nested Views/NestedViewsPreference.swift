//
//  NestedViewsPreference.swift
//  PrefKeyTests
//
//  Created by Miroslav Taleiko on 25.06.2022.
//

import SwiftUI

struct NestedPreferenceData: Identifiable {
    let id = UUID()
    let vtype: MyViewType
    let bounds: Anchor<CGRect>
    
    func getColor() -> Color {
        switch vtype {
        case .field(let length):
            return length == 0 ? .red : (length < 3 ? .yellow : .green)
        case .title:
            return .purple
        default:
            return .gray
        }
    }
    
    func show() -> Bool {
        switch vtype {
        case .field:
            return true
        case .title:
            return true
        case .fieldContainer:
            return true
        default:
            return false
        }
    }
}

struct NestedPreference: PreferenceKey {
    typealias Value = [NestedPreferenceData]
    
    static var defaultValue: [NestedPreferenceData] = []
    
    static func reduce(value: inout [NestedPreferenceData], nextValue: () -> [NestedPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}
