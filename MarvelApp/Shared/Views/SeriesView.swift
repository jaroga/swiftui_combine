//
//  SeriesView.swift
//  MarvelApp (iOS)
//
//  Created by José Ángel Rodríguez on 25/9/21.
//

import SwiftUI

struct SeriesView: View {
    @StateObject private var seriesViewModel: SeriesViewModel = SeriesViewModel()
    
    var character: Character
    
    var body: some View {
        if let dataSeries = seriesViewModel.series?.data.results {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(dataSeries) {serie in
                        SeriesRowView(serie: serie)
                    }
                }
            }
        }
    }
}

//struct SeriesView_Previews: PreviewProvider {
//    static var previews: some View {
//        SeriesView()
//    }
//}
