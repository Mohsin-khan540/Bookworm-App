//
//  DetailView.swift
//  Bookworm
//
//  Created by Mohsin khan on 15/09/2025.
//
import SwiftData
import SwiftUI

struct DetailView: View {
    let book : Book
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingAlert = false
    var body: some View {
        ScrollView{
            ZStack(alignment: .bottomTrailing){
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                
                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            Text(book.title)
                .font(.largeTitle.bold())
            Text(book.author)
                .font(.headline)
            Text(book.review)
                .padding()
            RatingView(rating : .constant(book.rating))
                .font(.largeTitle)
                .padding()
                .alert("Delete Book" , isPresented: $showingAlert){
                    Button("Delete" ,role: .destructive , action: deleteBook)
                    Button("Cancel" , role: .cancel){}
                }message: {
                    Text("are you sure to delete this book?")
                }
                .toolbar{
                    Button{
                        showingAlert = true
                    }label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.red)
                    }
                }
        }
    }
    func deleteBook(){
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for : Book.self , configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This was a great book; I really enjoyed it.", rating: 4)
       return DetailView(book: example)
            .modelContainer(container)
    }catch{
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
    }
   
