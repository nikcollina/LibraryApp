//
//  NoteView.swift
//  Library
//
//  Created by Nikolas Collina on 10/23/20.
//

import SwiftUI

struct NotesView: View {
    @EnvironmentObject var libraryModel : LibraryModel
    let index : Int
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(index: 0)
    }
}
