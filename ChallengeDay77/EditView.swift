//
//  EditView.swift
//  ChallengeDay77
//
//  Created by Xiaolong Zhang on 9/27/20.
//

import SwiftUI

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode

    @Binding var people: [Person]
    @State private var name = ""
    @State private var inputImage: UIImage?
    @State private var showImagePicker = false
    @State private var person: Person?
    private let dataManager = ManageData()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Name", text: $name)
                Button("Launch image picker") {
                    self.showImagePicker = true
                }
            }
            .sheet(isPresented: $showImagePicker, onDismiss: addPerson) {
                ImagePicker(image: $inputImage)
            }
            .navigationBarItems(trailing: Button("Save", action: {
                guard let person = person, let image = inputImage else { return }
                people.append(person)
                dataManager.save(people)
                dataManager.saveImage(pathName: name, uiImage: image)
                presentationMode.wrappedValue.dismiss()
            }))
        }
    }
    
    func addPerson() {
        person = Person(name: name)
    }
}
