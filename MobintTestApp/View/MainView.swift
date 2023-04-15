//
//  ContentView.swift
//  MobintTestApp
//
//  Created by Evgenii Mikhailov on 14.04.2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                ZStack {
                    Text("Управление картами")
                        .foregroundColor(Color("blue"))
                        .font(.system(size: 24))
                        .fontWeight(.regular)
                }
                .frame(width: geo.size.width, height: 70)
                .background(Color.white)
                
                if !viewModel.items.isEmpty {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(viewModel.items, id: \.self) { item in
                                Cell(cellViewModel: CellViewModel(item: item))
                                    .cornerRadius(15)
                                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                                    .onAppear {
                                        viewModel.loadMoreDataIfNeeded(currentItem: item)
                                    }
                            }
                        }
                        if viewModel.isLoading {
                            VStack {
                                ProgressView()
                                Text("Подгрузка компаний...")
                                Spacer()
                            }
                        }
                    }
                    
                }
                else {
                    VStack {
                        ProgressView()
                        Text("Подгрузка компаний...")
                        Spacer()
                    }
                    
                }
            }
            .background(Color("lightGrey"))
            .alert(item: $viewModel.error) { error in
                Alert(
                    title: Text("Ошибка"),
                    message: Text(error.rawValue),
                    dismissButton: .default(Text("OK"))
                )
            }
        
            .onAppear {
                viewModel.loadData(offset: 0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let viewModel = ViewModel()
    static var previews: some View {
        MainView()
            .onAppear{
                viewModel.loadData(offset: 0)
            }
    }
}

