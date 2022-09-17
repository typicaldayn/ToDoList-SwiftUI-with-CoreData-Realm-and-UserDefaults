//
//  MainView.swift
//  todolist_SwiftUI
//
//  Created by Stas Bezhan on 16.09.2022.
//
import RealmSwift
import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                picker
                list
            }
            .navigationTitle(viewModel.currentType)
            .alert("Save to \(viewModel.currentType)", isPresented: $viewModel.alertPresenting, actions: {
                TextField("Title", text: $viewModel.title)
                TextField("Text", text: $viewModel.text)
                Button("Save", role: .cancel) {
                    let newObject = AbstractObject(id: UUID(), text: viewModel.text, title: viewModel.title)
                    viewModel.dataManager.add(object: newObject)
                    viewModel.setObjects()
                    viewModel.text = ""
                    viewModel.title = ""
                }
                Button("Cancel", role: .destructive) {
                    viewModel.alertPresenting.toggle()
                }
            }, message: {
                Text("Create new object?")
            })
            
        }
    }
    
    @ViewBuilder var picker: some View {
            Section {
                Picker(selection: $viewModel.currentType.animation()) {
                    ForEach(viewModel.savingTypes, id: \.self) {
                        Text($0)
                    }
                } label: {
                    Text("Saving type")
                }
                .pickerStyle(.segmented)
                .onChange(of: viewModel.currentType, perform: { _ in
                    viewModel.changeDataManager()
                })
            } header: {
                Text("Select saving type")
        }
    }
    
    @ViewBuilder var list: some View {
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
                    viewModel.dataManager.delete(at: index)
                    viewModel.setObjects()
                })
            }
        } header: {
            HStack {
                Text("Objects of \n \(viewModel.currentType)")
                    .multilineTextAlignment(.center)
                Spacer()
                Button {
                    print(viewModel.objects)
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
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
