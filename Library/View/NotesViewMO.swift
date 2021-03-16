//
//  NotesViewMO.swift
//  Library
//
//  Created by Nikolas Collina on 10/29/20.
//

import SwiftUI

struct NotesViewMO: View {
    @ObservedObject var currentbook : BookMO
    @Environment(\.editMode) var editMode
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedItems = IndexSet()
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \NoteMO.time, ascending: false)],
                      animation: .default)
        private var notes: FetchedResults<NoteMO>
    
    var body: some View {
        VStack(alignment: .center){
            Text("Notes").font(.headline).padding()
            HStack{
                if editMode?.wrappedValue == .active{
                    Button(action: {addItem()}){
                        Image(systemName: "plus")
                    }
                    Spacer()
                    
                    Button(action: {
                        selectedItems.map {filterNotes(notes: notes)[$0]}.forEach(viewContext.delete)
                        selectedItems.removeAll()
                    }){
                        
                        Image(systemName: "trash")
                    }
                }
                Spacer()
                EditButton()
            }.padding()
            if filterNotes(notes: notes).count > 0 {
                ForEach(0..<filterNotes(notes: notes).count, id:\.self) { id in
                   
                    HStack{
                        DisclosureGroup(noteTitle(id: id)){
                        MONote(note: filterNotes(notes: notes)[id])
                        }.padding()
                        if editMode?.wrappedValue == .active{
                            SelectButton(index: id, selectedItems: $selectedItems)
                        }
                    }
                    
                }
            }
        }
    }
    func addItem(){
        let newNote = NoteMO(context: viewContext)
        newNote.text = ""
        newNote.progress = currentbook.currentPage
        newNote.time = Date()
        newNote.book = currentbook
    }

    func filterNotes(notes : FetchedResults<NoteMO>) -> [NoteMO] {
        var filteredNotes = [NoteMO]()
        filteredNotes = notes.filter({$0.book == currentbook})
        return filteredNotes
    }
    
    func noteTitle(id: Int)-> String{
        return ("Page: " + filterNotes(notes: notes)[id].progress +
                    " Time: " + getTime(time: filterNotes(notes: notes)[id].time))
    }
    
    func getTime(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: time)
    }
    
}

//struct NotesViewMO_Previews: PreviewProvider {
//    static var previews: some View {
//        NotesViewMO()
//    }
//}
