//
//  JournalDetail.swift
//  Journal
//
//  Created by Cameron Crockett on 11/15/24.
//

import SwiftUI

struct JournalDetail: View {
    
    @Binding var journal : JournalModel
    @ObservedObject var journalApp = JournalViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Journal Title", text: $journal.title)
                .font(.system(size: 25, weight: .bold))
            TextEditor(text: $journal.journalentry)
                .font(.system(size: 20))
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    journalApp.saveData(journal: journal)
                    journal.title = ""
                    journal.journalentry = ""
                } label: {
                    Text("Save")
                }
            }
        }
    }
}


struct NoteDetail_Previews: PreviewProvider {
    static var previews: some View {
        JournalDetail(journal: .constant(JournalModel(title: "one", journalentry: "one journal")))
    }
}
