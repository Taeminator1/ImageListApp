import SwiftUI

import ImageListPresentation
import ImageListData

@main
struct ImageListAppApp: App {
    var body: some Scene {
        WindowGroup {
            ImageListView()
//                .task {
//                    if let images = try? await ImageListRepositoryImpl().fetchImages() {
//                        // TODO: Replace with UI update
//                        images.forEach {
//                            print($0.id, $0.imageURL, $0.author)
//                        }
//                    } else {
//                        // TODO:
//                    }
//                }
        }
    }
}
