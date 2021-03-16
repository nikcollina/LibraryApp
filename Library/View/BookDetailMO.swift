//
//  BookDetailMO.swift
//  Library
//
//  Created by Nikolas Collina on 10/29/20.
//

import SwiftUI


struct BookDetailMO: View {
    @EnvironmentObject var libraryModel : LibraryModel
//    let index : Int
    @ObservedObject var book : BookMO
    
    
    let screenSize = UIScreen.main.bounds
    var body: some View {
        ScrollView{
            Text(book.title).font(.headline).padding()
            Image(book.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: screenSize.width * 0.75, height: screenSize.height * 0.75)
            if book.author != nil {
                Text("Author: " + book.author!)
            }
            Text("Country: " + book.country)
            Text("Language: " + book.language)
            Text("\(book.year)")
            ReadingButton(isReading: $book.reading)
            Text("Pages: " + "\(book.pages)")
            pageField
            NotesViewMO(currentbook: book)
        }
    }
    
    var pageField: some View {
        HStack{
            Text("Current Page:")
            TextField("Enter Current Page", text: $book.currentPage)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Done") {
                book.currentPage = libraryModel.checkPage(page: book.currentPage, lastPage: book.pages)
                book.currentPageInt = Int(book.currentPage) ?? 0
                self.hideKeyboard()
            }
        }.padding()
    }
}

//struct BookDetailMO_Previews: PreviewProvider {
//    static var previews: some View {
//        BookDetailMO(book: <#BookMO#>)
//    }
//}
