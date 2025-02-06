// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

import SwiftUI

struct ShowDetailsView {
    let show: ShowDetail
}

extension ShowDetailsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                if !show.imageURLString.isEmpty {
                    TVShowImage(urlString: show.imageURLString)
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    if !show.showName.isEmpty {
                        Text(show.showName)
                            .titleStyle()
                    }
                    
                    if !show.year.isEmpty {
                        Text(show.year)
                            .subHeadlineStyle()
                    }
                    
                    if !show.schedule.isEmpty {
                        Text(show.schedule)
                            .subHeadlineStyle()
                    }
                    
                    if !show.genres.isEmpty {
                        Text(show.genres)
                            .footNoteStyle()
                    }
                }
            }
            Divider()
            if !show.description.isEmpty {
                WebView(htmlContent: show.description)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(0)
            }
            Divider()
            if !show.rating.isEmpty {
                Text(show.rating)
                    .footNoteStyle()
                    
            }
            Spacer()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

#Preview {}
