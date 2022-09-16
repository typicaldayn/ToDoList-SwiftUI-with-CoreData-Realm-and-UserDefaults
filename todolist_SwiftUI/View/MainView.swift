//
//  MainView.swift
//  todolist_SwiftUI
//
//  Created by Stas Bezhan on 16.09.2022.
//

import SwiftUI

struct MainView: View {
    
    @State var type = ViewModel().currentType
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $viewModel.currentType) {
                        ForEach(viewModel.savingTypes, id: \.self) {
                            Text($0)
                        }
                    } label: {
                        Text("Saving type")
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select saving type")
                }
                Section {
                    //LISTS
                    List {
                        ForEach(viewModel.results, id: \.hashValue) { object in
                            VStack {
                                Text(object.title)
                                    .font(.headline)
                                    .multilineTextAlignment(.leading)
                                Text(object.text)
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        .onDelete(perform: viewModel.delete)
                    }
                } header: {
                    HStack {
                        Text("Objects of \n \(viewModel.currentType)")
                            .multilineTextAlignment(.center)
                        Spacer()
                        Button {
                            viewModel.alertPresenting.toggle()
                        } label: {
                            Text("New item to \n \(viewModel.currentType)")
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
            .alert("Save to \(viewModel.currentType)", isPresented: $viewModel.alertPresenting, actions: {
                TextField("Title", text: $viewModel.title)
                TextField("Text", text: $viewModel.text)
                Button("Save", role: .cancel) {
                    viewModel.add()
                }
                Button("Cancel", role: .destructive) {
                    viewModel.alertPresenting.toggle()
                }
            }, message: {
                Text("Create new object?")
            })
            .navigationTitle(viewModel.currentType)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
