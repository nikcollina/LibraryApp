//
//  CollectionRow.swift
//  Library
//
//  Created by Nikolas Collina on 10/20/20.
//

import SwiftUI

struct CollectionCard: View {
    @EnvironmentObject var libraryModel : LibraryModel
    let index : Int
    var body: some View {
        Text(libraryModel.books[index].title)
    }
}

struct CollectionRow_Previews: PreviewProvider {
    static var previews: some View {
        CollectionCard(index: 0)
    }
}
