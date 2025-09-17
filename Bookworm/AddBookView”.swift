//
//  AddBookView”.swift
//  Bookworm
//
//  Created by Mohsin khan on 14/09/2025.
//

import SwiftData
import SwiftUI

struct AddBookView_: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var validate : Bool {
        title.isEmpty || author.isEmpty || review.isEmpty
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Name of Book" , text: $title)
                    TextField("Author Name" , text: $author)
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id: \.self){ genre in
                            Text(genre)
                        }
                    }
                    
                }
                Section{
                    TextEditor(text: $review)
                    RatingView(rating: $rating , label: "Book Rating : ")
                }
            }
                .navigationTitle("Add new Book")
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Save"){
                            let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                            modelContext.insert(newBook)
                            dismiss()
                        }
                        .disabled(validate)
                        
                    }
                }
        }
    }
}

#Preview {
    AddBookView_()
}
