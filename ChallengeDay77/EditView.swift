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
                guard let person = person else { return }
                people.append(person)
                presentationMode.wrappedValue.dismiss()
            }))
        }
    }
    
    func addPerson() {
        guard let image = inputImage else { return }
        person = Person(name: name, image: image)
    }
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView()
//    }
//}
