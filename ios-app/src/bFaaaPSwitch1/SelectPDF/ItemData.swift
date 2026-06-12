//
//  ItemData.swift
//  bFaaaPSwitch1
//
//  Created by 宍戸知行 on 2020/12/18.
//  itemdata check for ootaki-san
// after ble1-1 is merged into ble1

import Foundation
import SwiftUI

final class StoredItem: NSObject, Identifiable, Codable {
    var id: Int
    var urlString: String
    var urlTitle: String
//    var listTitle: String
//
//    var creationDate: Date
    
    init(id: Int, urlString: String, urlTitle: String) {
        self.id = id
        self.urlString = urlString
        self.urlTitle = urlTitle
//        self.listTitle = listTitle
//        self.creationDate = creationDate
    }
}

struct PDFItemRow: View {
    var pdfItem: StoredItem
    
    
    var body: some View {
        HStack {
            Image(systemName: "music.note.list")
            .imageScale(.large)
            .foregroundColor(.yellow)
            
            Text(verbatim: pdfItem.urlTitle)
          
            Spacer()
            
        }
        .padding(.leading, 5)
        
        
       
    }
}
//comment
