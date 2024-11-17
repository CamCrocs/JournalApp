//
//  ContentView.swift
//  Journal
//
//  Created by Cameron Crockett on 11/15/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var journalApp = JournalViewModel()
    @State var journal = JournalModel(title: "", journalentry: "")
    @State private var isRefreshing = false
    @EnvironmentObject var authModel: AuthModel
    
    var body: some View { // had to find an alternative to .refreshable, since it's not in iOS 14
        NavigationView {
            VStack {
                if isRefreshing {
                    ProgressView("Refreshing, Please Wait.") // might not even need this
                        .padding()
                }
                
                List {
                    ForEach($journalApp.journals) { $journal in
                        NavigationLink {
                            JournalDetail(journal: $journal)
                        } label: {
                            Text(journal.title)
                        }
                    }
                    Section {
                        NavigationLink {
                            JournalDetail(journal: $journal)
                        } label: {
                            Text("New Journal")
                                .foregroundColor(Color.gray)
                                .font(.system(size: 15))
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .background(
                    Color.clear
                        .onAppear {
                            journalApp.fetchData()
                        }
                        .onTapGesture {
                            refreshData()
                        }
                )
                
                Button(action: {
                    authModel.signOut()
                }) {
                    Text("Sign Out")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.top, 20)
                }
            }
            .navigationTitle("Journals")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func refreshData() {
        isRefreshing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            journalApp.fetchData()
            isRefreshing = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

