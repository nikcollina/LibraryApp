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
    let screenSize = UIScreen.main.bounds
    var body: some View {
            VStack{
                NavigationLink(destination: BookDetail(index: index)){
                Image(libraryModel.books[index].image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenSize.width / 3.75, height: screenSize.width / 3)
                }
            }
        
    }
}

struct CollectionRow_Previews: PreviewProvider {
    static var previews: some View {
        CollectionCard(index: 0)
    }
}
