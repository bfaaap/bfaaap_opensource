//
//  SelectPDF.swift
//  bFaaaPSwitch1
//
//  Created by 宍戸知行 on 2020/12/05.
//

import SwiftUI
import MobileCoreServices
import UniformTypeIdentifiers

struct  DocumentPicker :UIViewControllerRepresentable {
   
    @Binding var urlString:String
    @Binding var filename:String
    
    func makeCoordinator() -> DocumentPicker.Coordinator {
        
        return DocumentPicker.Coordinator(parent1: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        let supportedTypes: [UTType] = [UTType.pdf]
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
        
    }
    
    
    class Coordinator: NSObject, UIDocumentPickerDelegate{
        
        var parent: DocumentPicker
        
        
        init(parent1: DocumentPicker){
            parent = parent1
            
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            print(urls)
            print(urls.first!)
            
            self.parent.urlString = urls.first!.absoluteString
            self.parent.filename =  String(urls.first!.lastPathComponent)
            //アプリフォルダにこの時点で保存コピーする
            do {
            let documentsURL = try
                FileManager.default.url(for: .documentDirectory,
                                        in: .userDomainMask,
                                        appropriateFor: nil,
                                        create: false)
                print("documentsURLは\(documentsURL)")
            let savedURL = documentsURL.appendingPathComponent(
                "\(String(urls.first!.lastPathComponent))")
            let encodedSavedURLpath = savedURL.path.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
                print("encodedSavedURLpathは\(String(describing: encodedSavedURLpath))")
                if FileManager.default.fileExists(atPath: encodedSavedURLpath!) {
                    try FileManager.default.removeItem(atPath:encodedSavedURLpath!)
                    print("There is an already file at the encodedSavedURLpath and the file is deleted.")
                    
                }
                try FileManager.default.copyItem(atPath:urls.first!.path, toPath:encodedSavedURLpath!)
                print("the selected file has been copied.")
                
                //UserDefaultsに値を保存
                UserDefaults.standard.set(urls.first!.absoluteString, forKey: "urlString")
                
            }catch let error as NSError {
                print("Couldn't copy file to final location! Error:\(error.description)")
            }
           
        }
    }
}

