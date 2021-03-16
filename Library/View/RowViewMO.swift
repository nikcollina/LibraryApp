//
//  RowViewMO.swift
//  Library
//
//  Created by Nikolas Collina on 10/29/20.
//

import SwiftUI

struct RowViewMO: View {
    @ObservedObject var book : BookMO
    var body: some View {
        NavigationLink(destination: BookDetailMO(book: book)){
            Text(book.title)
        }
    }
}

//struct RowViewMO_Previews: PreviewProvider {
//    static var previews: some View {
//        RowViewMO()
//    }
//}
