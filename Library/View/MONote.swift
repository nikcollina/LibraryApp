//
//  MONote.swift
//  Library
//
//  Created by Nikolas Collina on 10/30/20.
//

import SwiftUI

struct MONote: View {
    @ObservedObject var note : NoteMO
    @Environment(\.editMode) var editMode
    var body: some View {
        HStack{
            TextField("Enter Note", text: $note.text).disabled(self.editMode?.wrappedValue == .inactive)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

//struct MONote_Previews: PreviewProvider {
//    static var previews: some View {
//        MONote()
//    }
//}
