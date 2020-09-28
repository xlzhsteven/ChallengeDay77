//
//  ContentView.swift
//  ChallengeDay77
//
//  Created by Xiaolong Zhang on 9/27/20.
//

import SwiftUI

struct ContentView: View {
    @State private var people = [Person]()
    @State private var showEditView = false
    private var sortedPeople: [Person] {
        people.sorted()
    }
    
    var body: some View {
        NavigationView {
            List(sortedPeople) { person in
                NavigationLink(person.name, destination: Text(person.name))
            }
            .navigationBarItems(trailing: Button(action: {
                self.showEditView = true
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $showEditView) {
                EditView(people: self.$people)
            }
        }
    }
}

struct Person: Identifiable, Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
    let id = UUID()
    let name: String
    let image: UIImage
}
