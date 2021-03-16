//
//  NoteView.swift
//  Library
//
//  Created by Nikolas Collina on 10/23/20.
//

import SwiftUI

struct NotesView: View {
    @EnvironmentObject var libraryModel : LibraryModel
    let index : Int
    @Environment(\.editMode) var editMode
    @State private var selectedItems = IndexSet()
    
    
    
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
                        libraryModel.delete(book: index, at: selectedItems)
                        selectedItems.removeAll()
                    }){
                        
                        Image(systemName: "trash")
                    }
                }
                Spacer()
                EditButton()
            }.padding()
            if libraryModel.noteCount(index: index) > 0{
                ForEach(0..<libraryModel.noteCount(index: index)-1, id:\.self) { id in
                    VStack{
                        
                        DisclosureGroup(noteTitle(id: id)){
                            HStack{
                                TextField("Enter Note", text: $libraryModel.books[index].notes[id]).disabled(self.editMode?.wrappedValue == .inactive)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                if editMode?.wrappedValue == .active{
                                    SelectButton(index: id, selectedItems: $selectedItems)
                                }
                            }.padding()
                        }
                        
                    }.padding()
                }
            }
        }
    }
    func addItem(){
        libraryModel.books[index].notes.insert("", at: 0)
        libraryModel.books[index].noteProgress.insert(libraryModel.books[index].currentPage, at: 0)
        libraryModel.books[index].noteDate.insert(libraryModel.getTime(), at: 0)
    }
    func noteTitle(id: Int)-> String{
        return ("Page: " + libraryModel.books[index].noteProgress[id] +
                    " Time: " + libraryModel.books[index].noteDate[id])
    }
    
}

struct SelectButton : View {
    var index : Int
    @Binding var selectedItems : IndexSet
    var body : some View {
        Button(action: {toggle(index, in: $selectedItems)},
               label: {imageFor(index, in: selectedItems) })
    }
    
    func toggle(_ index: Int, in selectedItems : Binding<IndexSet>) {
        if selectedItems.wrappedValue.contains(index) {
            selectedItems.wrappedValue.remove(index)
        } else {
            selectedItems.wrappedValue.insert(index)
        }
    }
    
    func imageFor(_ index:Int, in selectedItems:IndexSet) -> some View {
        let isSelected = selectedItems.contains(index)
        return  Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
            .renderingMode(.template)
            .foregroundColor(isSelected ? .blue : .gray)
    }

}


struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(index: 0)
    }
}
