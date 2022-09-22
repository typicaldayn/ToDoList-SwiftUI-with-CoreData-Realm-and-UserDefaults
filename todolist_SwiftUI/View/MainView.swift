//
//  MainView.swift
//  todolist_SwiftUI
//
//  Created by Stas Bezhan on 16.09.2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                picker
                list
            }
            .navigationTitle(viewModel.currentType.rawValue)
            .alert("Save to \(viewModel.currentType.rawValue)",
                   isPresented: $viewModel.alertPresenting,
                   actions: {
                TextField("Title", text: $viewModel.title)
                TextField("Text", text: $viewModel.text)
                Button("Save", role: .none) {
                    viewModel.addNewObject()
                }
                Button("Cancel", role: .none) {
                    viewModel.alertPresenting.toggle()
                }
            }, message: {
                Text("Create new object?")
            })
            
        }
    }
    
    var picker: some View {
            Section {
                Picker(selection: $viewModel.currentType.animation()) {
                    ForEach(viewModel.savingTypes, id: \.self) {
                        Text($0.rawValue)
                    }
                } label: {
                    Text("Saving type")
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Select saving type")
        }
    }
    
    var list: some View {
        Section {
            List {
                ForEach(viewModel.objects, id: \.hashValue) { object in
                    VStack {
                        Text(object.title)
                            .font(.headline)
                        Text(object.text)
                            .font(.body)
                    }
                    .multilineTextAlignment(.leading)
                }
                .onDelete(perform: { index in
                    viewModel.delete(at: index)
                })
            }
        } header: {
            HStack {
                Text("Objects of \n \(viewModel.currentType.rawValue)")
                    .multilineTextAlignment(.center)
                Spacer()
                Button {
                    print(viewModel.objects)
                    viewModel.alertPresenting.toggle()
                } label: {
                    Text("New item to \n \(viewModel.currentType.rawValue)")
                        .font(.caption)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
