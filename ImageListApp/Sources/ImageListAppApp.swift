import SwiftUI

import ImageListPresentation
import ImageListData

@main
struct ImageListAppApp: App {
    var body: some Scene {
        WindowGroup {
            ImageListView(repository: ImageListRepositoryImpl())
        }
    }
}
