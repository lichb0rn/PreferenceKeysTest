//
//  NestedFormField.swift
//  PrefKeyTests
//
//  Created by Miroslav Taleiko on 25.06.2022.
//

import SwiftUI

struct NestedFormField: View {
    @Binding var fieldValue: String
    let label: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
            
            TextField("", text: $fieldValue)
                .textFieldStyle(.roundedBorder)
                .anchorPreference(key: NestedPreference.self, value: .bounds) {
                    return [NestedPreferenceData(vtype: .field(self.fieldValue.count), bounds: $0)]
                }
                .padding(15)
                .background {
                    RoundedRectangle(cornerRadius: 15).fill(Color(white: 0.9))
                }
                .transformAnchorPreference(key: NestedPreference.self, value: .bounds) {
                    $0.append(NestedPreferenceData(vtype: .fieldContainer, bounds: $1))
                }
        }
    }
}

//struct NestedFormField_Previews: PreviewProvider {
//    static var previews: some View {
//        NestedFormField()
//    }
//}
