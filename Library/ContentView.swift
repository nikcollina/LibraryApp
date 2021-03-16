//
//  ContentView.swift
//  Library
//
//  Created by Nikolas Collina on 10/19/20.
//

import SwiftUI

struct CollectionView: View {
    @ObservedObject var libraryModel = LibraryModel()
    var body: some View {
        VStack {
            List{
                ForEach(libraryModel.books.indices, id:\.self ) {index in
                    Text(libraryModel.books[index].title)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}
