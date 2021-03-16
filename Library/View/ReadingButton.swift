//
//  ReadingButton.swift
//  Library
//
//  Created by Nikolas Collina on 10/21/20.
//

import SwiftUI

struct ReadingButton: View {
    @Binding var isReading : Bool
    var body: some View {
        Button(action: {self.isReading.toggle()}) {
            ZStack {
                RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
                    .stroke(isReading ? Color.red : .green, lineWidth: ViewConstants.lineWidth)
                    .frame(width: ViewConstants.readingButtonWidth, height: ViewConstants.readingButtonHeight)
                Text(isReading ? "Mark as Not Reading" : "Mark as Reading")
                    .foregroundColor(isReading ? .red : .green)
            }
        }
    }
}

struct ReadingButton_Previews: PreviewProvider {
    @State static var reading = false
    static var previews: some View {
        ReadingButton(isReading: $reading)
    }
}
