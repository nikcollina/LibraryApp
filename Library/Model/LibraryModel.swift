//
//  LibraryModel.swift
//  Library
//
//  Created by Nikolas Collina on 10/19/20.
//

import Foundation

enum BooksDisplayed : String, CaseIterable {
    case All, Reading, Finished
}

typealias Books = [Book]

class LibraryModel : ObservableObject {
    @Published var books : [Book]
    
    let destinationURL : URL
    
    init() {
        let filename = "books"
        let mainBundle = Bundle.main
        let bundleURL = mainBundle.url(forResource: filename, withExtension: "json")!

        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        destinationURL = documentURL.appendingPathComponent(filename + ".json")
        let fileExists = fileManager.fileExists(atPath: destinationURL.path)

        do {
            let url = fileExists ? destinationURL : bundleURL
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            books = try decoder.decode(Books.self, from: data)

        }
        catch {
            print("Error info: \(error)")
            books = []
        }
        

    }
    func saveData() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(books)
            try data.write(to: self.destinationURL)
        } catch {
            print("Error writing: \(error)")
        }
    }
    
    @Published var booksDisplayed : BooksDisplayed = .All
    
    
    
    var indicies = [Int]()
    
    var allBooksIndicies = [Int]()
    var finishedIndices = [Int]()
    var readingIndices = [Int]()
    
    func getIndicies() -> [Int] {
        switch booksDisplayed {
        case .All:
            indicies = allBooksIndicies
        case .Reading:
            indicies = readingIndices
        case .Finished:
            indicies = finishedIndices
        }
        return indicies
    }
    
    func filterIndices() -> [Int] {
        var filteredBooks = [Book]()
        if booksDisplayed == .All {
            filteredBooks = books
        }
        if booksDisplayed == .Reading{
            filteredBooks = books.filter({$0.reading == true})
        }
        if booksDisplayed == .Finished{
            filteredBooks = books.filter({Int($0.currentPage) == $0.pages})
        }
        let indicies = filteredBooks.map{b in books.firstIndex(where: {$0.title == b.title})!}
        return indicies
    }
    
    func count()-> Int {
        return filterIndices().count
    }
    
    func test() -> Int {
        var count = 0
        for book in books {
            if book.reading {
                count = count + 1
            }
        }
        return count
    }
    
    func yearOut(year : Int) -> String {
        var output = ""
        if year < 0 {
            output = String(format: "Year: %0d B.C.", abs(year))
        }
        else {
            output = String(format: "Year: %0d A.D.", year)
        }
        return output
    }
    
    func checkPage(page : String, lastPage : Int) -> String{
        let pageNumber = Int(page) ?? 0
        if pageNumber > lastPage {
            return "\(lastPage)"
        }
        else {
            return page
        }
    }
    
//    func addNote() {
//        
//    }
    func noteCount(index : Int) -> Int {
        let notes = books[index].notes
        return notes.count
    }
    func delete(book: Int, at : IndexSet) {
        books[book].notes.remove(atOffsets: at)
        books[book].noteProgress.remove(atOffsets: at)
    }
    
    func getTime() -> String {
        let currentTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: currentTime)
    }
    
}
