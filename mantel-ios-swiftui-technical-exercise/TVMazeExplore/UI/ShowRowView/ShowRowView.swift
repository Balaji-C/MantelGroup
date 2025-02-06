// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

import SwiftUI

struct ShowRowView {
    let show: ShowDetail
}

extension ShowRowView: View {
    var body: some View {
        HStack(spacing:12) {
            if !show.imageURLString.isEmpty {
                TVShowImage(urlString: show.imageURLString)
            }
            VStack(alignment: .leading) {
                if !show.showName.isEmpty {
                    Text(show.showName)
                        .titleStyle()
                }
                
                if !show.schedule.isEmpty {
                    Text(show.schedule)
                        .subHeadlineStyle()
                    Spacer()
                }
            }
            .padding()
        }
    }
}

#Preview {}
