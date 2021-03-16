//
//  ContentView.swift
//  Library
//
//  Created by Nikolas Collina on 10/19/20.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var libraryModel : LibraryModel
    @Environment(\.managedObjectContext) private var viewContext
    @State var ListView = false
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \BookMO.title, ascending: true)],
                  
                      animation: .default)
        private var allBooks: FetchedResults<BookMO>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \BookMO.title, ascending: true)],
                  predicate: NSPredicate(format:"reading == true" ),
                      animation: .default)
        private var readingBooks: FetchedResults<BookMO>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \BookMO.title, ascending: true)],
                  predicate: NSPredicate(format:"currentPageInt == pages" ),
                      animation: .default)
        private var finishedBooks: FetchedResults<BookMO>
    
    
    var body: some View {
        let books = pickBooks(type: libraryModel.booksDisplayed)
        NavigationView {
            
            if (ListView){
                List{
                    if books.count == 0 {
                        Text(libraryModel.booksDisplayed == .Reading ? "No Books Being Read" : "No Books Finished")
                    }
                    ForEach(books, id:\.self) {book in
                        RowViewMO(book: book)
                    }
                }.navigationBarTitle("Library")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: StylePicker ,trailing: DisplayPicker)

            }
            else{
                ScrollView {
                    if books.count == 0 {
                        Text(libraryModel.booksDisplayed == .Reading ? "No Books Being Read" : "No Books Finished")
                    }
                    LazyVStack {
                        ForEach(0..<Int(ceil(Double(books.count) / Double(ViewConstants.columns))), id: \.self) {row in
                            LazyHStack(spacing: ViewConstants.cardSpacing) {
                                ForEach(0..<ViewConstants.columns, id: \.self) {column in
                                    if (row * ViewConstants.columns + column) < (books.count) {
                                        CollectionCardMO(book: books[(row * ViewConstants.columns) + column])
                                    }
                                }
                            }
                        }
                    }
                }.navigationBarTitle("Library")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: StylePicker ,trailing: DisplayPicker)
            }
        }.onAppear() {
            addBooks()
            }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(libraryModel)
        
    }
    
    var DisplayPicker : some View {
        Picker("Type", selection: $libraryModel.booksDisplayed){
            ForEach(BooksDisplayed.allCases, id:\.self) { value in
                Text("\(value.rawValue)")
            }
        }.pickerStyle(MenuPickerStyle())
    }
    var StylePicker : some View {
        Button(action: {self.ListView.toggle()}) {
            Image(systemName: ListView ? "square.grid.3x3.fill" : "list.dash")
        }
    }
    
    
    //  Core Data
    
    let alreadyLoadedKey = "AlreadyLoaded"
    
    func addBooks() {
        let userDefaults = UserDefaults.standard
        let alreadyLoaded = userDefaults.bool(forKey: alreadyLoadedKey)
        if !alreadyLoaded {
            //TODO: Create Player managed objects
            libraryModel.books.forEach {(book) in
                addBook(book: book)
                save()  // need this here so fetch results get updated!
            }
            
            userDefaults.set(true, forKey: alreadyLoadedKey)
            userDefaults.synchronize()
        }
    }
    func addBook(book:Book) {
        let newBook = BookMO(context: viewContext)
        if book.author != nil {
            newBook.author = book.author!
        }
        newBook.country = book.country
        newBook.image = book.image
        newBook.language = book.language
        newBook.link = book.link
        newBook.pages = book.pages
        newBook.title = book.title
        newBook.year = book.year
        newBook.reading = book.reading
        newBook.currentPage = book.currentPage
        
        newBook.currentPageInt = Int(book.currentPage) ?? 0
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func pickBooks(type: BooksDisplayed) -> FetchedResults<BookMO>{
        switch type {
        case .All:
            return allBooks
        case .Reading:
            return readingBooks
        case .Finished:
            return finishedBooks
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}
