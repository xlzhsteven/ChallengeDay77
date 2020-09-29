//
//  ContentView.swift
//  ChallengeDay77
//
//  Created by Xiaolong Zhang on 9/27/20.
//

// ✓ Wrap UIImagePickerController so it can be used to select photos.
// ✓ Detect when a new photo is imported, and immediately ask the user to name the photo.
//  Save that name and photo somewhere safe.
// ✓ Show all names and photos in a list, sorted by name.
// ✓ Create a detail screen that shows a picture full size.
//  Decide on a way to save all this data.

import SwiftUI

struct ContentView: View {
    @State private var people = [Person]()
    @State private var showEditView = false
    private let dataManager = ManageData()
//    private var sortedPeople: [Person] {
//        dataManager.loadPeople().sorted()
//    }
    
    var body: some View {
        NavigationView {
            List(people) { person in
                NavigationLink(destination: ImageFullScreenView(inputImage: dataManager.loadImage(pathName: person.name) ?? UIImage())) {
                    PersonRow(person: person)
                }
            }
            .navigationBarItems(trailing: Button(action: {
                self.showEditView = true
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $showEditView, onDismiss: loadPeople) {
                EditView(people: self.$people)
            }
            .navigationTitle(Text("Image list"))
            .onAppear(perform: loadPeople)
        }
    }
    
    func loadPeople() {
        people = dataManager.loadPeople().sorted()
    }
}

struct Person: Codable, Identifiable, Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
    let id = UUID()
    let name: String
}

struct PersonRow: View {
    var person: Person
    private let dataManager = ManageData()
    
    var body: some View {
        HStack {
            Image(uiImage: dataManager.loadImage(pathName: person.name) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            Text(person.name)
        }
        .padding()
    }
}
