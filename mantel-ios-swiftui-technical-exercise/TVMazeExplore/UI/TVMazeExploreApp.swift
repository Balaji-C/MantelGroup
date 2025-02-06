import SwiftUI

@main
struct TVMazeExploreApp: App {
    @StateObject var networkMonitor = NetworkMonitor.shared
    @StateObject var viewModel = ShowViewModel(service: APIRepository(networkMonitor: NetworkMonitor.shared))
    
    var body: some Scene {
        WindowGroup {
            ShowView(viewModel: viewModel)
                .environmentObject(networkMonitor)
        }
    }
}
