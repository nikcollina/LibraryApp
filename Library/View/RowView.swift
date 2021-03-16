//
//  RowView.swift
//  Library
//
//  Created by Nikolas Collina on 10/22/20.
//

import SwiftUI

struct RowView: View {
    @EnvironmentObject var libraryModel : LibraryModel
    let index : Int
    var body: some View {
        NavigationLink(destination: BookDetail(index: index)){
            Text(libraryModel.books[index].title)
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(index: 0)
    }
}
