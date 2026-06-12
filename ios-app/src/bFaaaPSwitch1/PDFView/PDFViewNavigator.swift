//
//  PDFViewNavigator.swift
//  bFaaaPSwitch1
//
//  Created by 宍戸知行 on 2020/12/02.
//

import PDFKit
import SwiftUI


class PDFViewNavigator {
    weak var pdfView: PDFKit.PDFView?
    
    func goBack() {
        pdfView?.goBack(nil)
    }
    
    func goForward() {
        pdfView?.goForward(nil)
    }
    
    func goToPreviousPage() {
        pdfView?.goToPreviousPage(nil)
    }
    
    func goToNextPage() {
        pdfView?.goToNextPage(nil)
    }
}

struct PDFView: UIViewRepresentable {
    let url: URL
    unowned var navigator: PDFViewNavigator
    
    func makeUIView(context: Context) -> PDFKit.PDFView {
        let pdfView = PDFKit.PDFView()
        pdfView.document = PDFDocument(url: self.url)
        pdfView.autoScales = true
        pdfView.displayMode = .singlePage
        pdfView.displayDirection = .horizontal
        pdfView.displaysPageBreaks = true
        pdfView.pageBreakMargins = .zero
        pdfView.usePageViewController(true, withViewOptions: nil)
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFKit.PDFView, context: Context) {
        navigator.pdfView = uiView
    }
}



