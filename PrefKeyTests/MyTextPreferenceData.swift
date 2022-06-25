//
//  MyTextPreferenceData.swift
//  PrefKeyTests
//
//  Created by Miroslav Taleiko on 25.06.2022.
//

import SwiftUI

struct MyTextPreferenceData {
    let viewIdx: Int
    var topLeading: Anchor<CGPoint>? = nil
    var bottomTrailing: Anchor<CGPoint>? = nil
}


struct MyTextPrefernceKey: PreferenceKey {
    // typealias that indicates what type of information we want to expose through the preference
    typealias Value = [MyTextPreferenceData]
    
    // When a preference key value has not been set explicitly, SwiftUI will use this defaultValue.
    static var defaultValue: [MyTextPreferenceData] = []
    
    // a static function that SwiftUI will use to merge all the key values found in the view tree
    static func reduce(value: inout [MyTextPreferenceData], nextValue: () -> [MyTextPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}
