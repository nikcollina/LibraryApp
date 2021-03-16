//
//  CollectionCardMO.swift
//  Library
//
//  Created by Nikolas Collina on 10/29/20.
//

import SwiftUI

struct CollectionCardMO: View {
    @ObservedObject var book : BookMO
    let screenSize = UIScreen.main.bounds
    var body: some View {
        VStack{
            NavigationLink(destination: BookDetailMO(book: book)){
            Image(book.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: screenSize.width / 3.75, height: screenSize.width / 3)
            }
        }
    }
}

//struct CollectionCardMO_Previews: PreviewProvider {
//    static var previews: some View {
//        CollectionCardMO()
//    }
//}
