// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

import SwiftUI

struct TVShowImage : View  {
    let urlString : String
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: urlString)) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 120, height: 160)
        }
    }
}
