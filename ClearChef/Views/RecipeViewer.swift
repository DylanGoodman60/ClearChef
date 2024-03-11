import SwiftUI

struct RecipeViewer: View {
    @State private var selectedTab = 0

    var body: some View {
        ScrollView {
            TabView(selection: $selectedTab) {
                Text("First Tab")
                    .tabItem {
                        Image(systemName: "1.circle")
                        Text("First")
                    }
                    .tag(0)
                
                Text("Second Tab")
                    .tabItem {
                        Image(systemName: "2.circle")
                        Text("Second")
                    }
                    .tag(1)
                
                Text("Third Tab")
                    .tabItem {
                        Image(systemName: "3.circle")
                        Text("Third")
                    }
                    .tag(2)
            }
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .gesture(DragGesture()
                        .onEnded({ value in
                            if value.translation.height > 100 {
                                // Swipe up
                                if selectedTab > 0 {
                                    selectedTab -= 1
                                }
                            } else if value.translation.height < -100 {
                                // Swipe down
                                if selectedTab < 2 {
                                    selectedTab += 1
                                }
                            }
                        })
            )
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

