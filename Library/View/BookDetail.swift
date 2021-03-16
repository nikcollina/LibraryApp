//
//  BookDetail.swift
//  Library
//
//  Created by Nikolas Collina on 10/19/20.
//

import SwiftUI

/* got this function from https://www.hackingwithswift.com/quick-start/swiftui/how-to-dismiss-the-keyboard-for-a-textfield */
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct BookDetail: View {
    @EnvironmentObject var libraryModel : LibraryModel
    let index : Int
    let screenSize = UIScreen.main.bounds
    var body: some View {
        ScrollView{
            Text(libraryModel.books[index].title).font(.headline).padding()
            Image(libraryModel.books[index].image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: screenSize.width * 0.75, height: screenSize.height * 0.75)
            if libraryModel.books[index].author != nil {
                Text("Author: " + libraryModel.books[index].author!)
            }
            Text("Country: " + libraryModel.books[index].country)
            Text("Language: " + libraryModel.books[index].language)
            Text(libraryModel.yearOut(year: libraryModel.books[index].year))
            ReadingButton(isReading: $libraryModel.books[index].reading)
            Text("Pages: " + "\(libraryModel.books[index].pages)")
            pageField            
            NotesView(index: index)
        }
    }
    
    var pageField: some View {
        HStack{
            Text("Current Page:")
            TextField("Enter Current Page", text: $libraryModel.books[index].currentPage)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Done") {
                libraryModel.books[index].currentPage = libraryModel.checkPage(page: libraryModel.books[index].currentPage, lastPage: libraryModel.books[index].pages)
                self.hideKeyboard()
            }
        }.padding()
    }
}

struct BookDetail_Previews: PreviewProvider {
    static var previews: some View {
        BookDetail(index: 0)
    }
}
