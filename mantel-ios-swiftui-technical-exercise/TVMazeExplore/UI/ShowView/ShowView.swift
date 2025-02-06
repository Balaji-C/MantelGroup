// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

import SwiftUI

struct ShowView {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @ObservedObject var viewModel: ShowViewModel
    @State private var searchString: String = ""
}

extension ShowView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                HStack {
                    TextField("Search TV Shows...", text: $searchString, onCommit: {
                        Task {
                            viewModel.resetData()
                            await viewModel.fetchShows(searchString: searchString)
                        }
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .submitLabel(.search)
                }
                
                if viewModel.isLoading {
                    ProgressView("Fetching Shows ....")
                        .padding()
                } else if viewModel.shows.isEmpty && !viewModel.isLoading {
                    Text("No results found.")
                        .foregroundColor(.gray)
                        .padding()
                }
                else if let error = viewModel.errorMessage {
                    Text(error)
                        .errorStyle()
                        .padding()
                } else {
                    List(viewModel.shows) { show in
                        NavigationLink(destination: ShowDetailsView(show: show)) {
                            ShowRowView(show: show)
                        }
                    }
                    .navigationTitle("TV Shows")
                    .listStyle(.plain)
                }
            }
        }
    }
}
