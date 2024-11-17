//
//  JournalViewModel.swift
//  Journal
//
//  Created by Cameron Crockett on 11/15/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class JournalViewModel : ObservableObject {
    
    @Published var journals = [JournalModel]()
    let db = Firestore.firestore()
    
    func fetchData() {
        
        db.collection("journal")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            self.journals.append(try document.data(as: JournalModel.self))
                        } catch {
                            print(error)
                        }
                    }
                }
        }
    }
    
    func saveData(journal: JournalModel) {
        
        if let id = journal.id {
            
            if !journal.title.isEmpty || !journal.journalentry.isEmpty {
                let docRef = db.collection("journal").document(id)
                docRef.updateData([
                    "title": journal.title,
                    "journalentry": journal.journalentry
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            }
        } else {
            if !journal.title.isEmpty || !journal.journalentry.isEmpty {
                var ref: DocumentReference? = nil
                ref = db.collection("journal").addDocument(data: [
                    "title": journal.title,
                    "journalentry": journal.journalentry
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }
            }
        }
    }
}
