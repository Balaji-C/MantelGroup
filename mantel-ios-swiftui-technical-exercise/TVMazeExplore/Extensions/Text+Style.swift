// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

import SwiftUI

extension Text {
    func titleStyle() -> some View {
        self
            .font(.title)
            .foregroundColor(.title)
            .lineLimit(2)
    }
    
    func subHeadlineStyle() -> some View {
        self
            .font(.subheadline)
            .foregroundColor(.subHeadline)
            .lineLimit(2)
    }
    
    func footNoteStyle() -> some View {
        self
            .font(.footnote)
            .foregroundColor(.footNote)
            .lineLimit(2)
    }
    
    func errorStyle() -> some View {
        self
            .font(.headline)
            .foregroundColor(.error)
            .multilineTextAlignment(.center)
    }
}
