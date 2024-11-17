//
//  JournalModel.swift
//  Journal
//
//  Created by Cameron Crockett on 11/15/24.
//

import Foundation
import FirebaseFirestoreSwift

struct JournalModel : Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var journalentry: String
}
