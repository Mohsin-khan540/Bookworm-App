//
//  ContentView.swift
//  Bookworm
//
//  Created by Mohsin khan on 12/09/2025.

import SwiftData
import SwiftUI

struct ContentView : View {
    @Environment(\.modelContext) var modelContext
    @State private var ShowAddScreen = false
    // simple way of sorting
    
//    @Query(sort : \Book.rating , order: .reverse) var books : [Book]
    
    // if titls same then decide on author
    
    @Query(sort :[SortDescriptor(\Book.title) , SortDescriptor(\Book.author)]) var books : [Book]
    var body: some View {
        
        
        NavigationStack{
            List{
                ForEach(books){book in
                    NavigationLink(value : book){
                        HStack{
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading){
                                Text(book.title)
                                    .foregroundStyle(color(for: book.rating))
                                    .font(.headline)
                                Text(book.author)
                                    .font(.caption)
                                Text(book.date.formatted(date : .abbreviated , time : .shortened) )
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
           
            
                .navigationTitle("Bookworm")
                .navigationDestination(for: Book.self){book in
                    DetailView(book: book)
                }
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button{
                            ShowAddScreen.toggle()
                        }label: {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading){
                        EditButton()
                    }
                    
                }
                .sheet(isPresented: $ShowAddScreen){
                    AddBookView_()
                }
        }
    }
    func deleteBooks(at offsets: IndexSet) {
        for index in offsets {
            let book = books[index]
            modelContext.delete(book)
        }
    }
    
    func color(for rating : Int)-> Color{
        switch rating {
        case 1: return .red
        case 2: return .orange
        case 3: return .yellow
        case 4: return .green
        case 5: return .green
        default: return .primary
        }
    }

}

#Preview {
    ContentView()
}
