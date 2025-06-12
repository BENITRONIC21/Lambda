//
//  ContentView.swift
//  Lambda
//
//  Created by Benito Antuñano Idargo on 05/06/25.
//

import SwiftUI
import AVKit
import UIKit

// In your App or View init:


class PlayerUIView: UIView {
    let playerLayer = AVPlayerLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

struct ContentView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch selectedTab {
                case .home:
                    HomeView()
                case .forum:
                    ForumView()
                case .practice:
                    PracticeView()
                case .combat:
                    CombatView()
                case .profile:
                    ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Divider above tab bar
            Rectangle()
                .fill(Color(red: 0.45, green: 0.45, blue: 0.45))
                .frame(height: 1)

            // Custom Tab Bar
            HStack {
                TabBarButton(tab: .home, selectedTab: $selectedTab, icon: .system("house.fill"), label: "Home")
                TabBarButton(tab: .forum, selectedTab: $selectedTab, icon: .system("bubble.left.and.bubble.right.fill"), label: "Forum")
                TabBarButton(tab: .practice, selectedTab: $selectedTab, icon: .system("function"), label: "Practice")
                TabBarButton(tab: .combat, selectedTab: $selectedTab, icon: .system("shield.lefthalf.fill"), label: "Combat")
                TabBarButton(tab: .profile, selectedTab: $selectedTab, icon: .system("person.crop.circle.fill"), label: "Profile")
            }
            .padding(.vertical, 10)
            .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

enum Tab {
    case home, forum, practice, combat, profile
}
enum TabIcon {
    case system(String)
    case custom(Image)
}

struct TabBarButton: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    let icon: TabIcon
    let label: String

    var isSelected: Bool {
        selectedTab == tab
    }

    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack {
                switch icon {
                case .system(let name):
                    Image(systemName: name)
                        .font(.system(size: 24))
                case .custom(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                Text(label)
                    .font(.caption)
            }
            .foregroundColor(isSelected ? Color(red: 0.3608, green: 0.8784, blue: 0.6118) : .white)
            .frame(maxWidth: .infinity)
        }
    }
}



struct CustomNavigationBar: View {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground() // Makes nav bar background transparent
        appearance.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1) // Your grey color
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                NavigationLink(destination: LambdaInfoView()) {
                    HStack(spacing: 0) {
                        Image("logo3-real")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90, height: 90)
                            .padding(.leading, -20)

                        VStack(alignment: .leading, spacing: 2) {
                            Text("This is")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .thin))
                            Text("Lambda.")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .bold))
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle()) // Removes the blue highlight from the NavigationLink


                Spacer()

                HStack(spacing: 18) {
                    Button(action: {
                        print("Settings tapped")
                    }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                    }

                    Button(action: {
                        print("Help tapped")
                    }) {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, -20)
            .padding(.bottom, 0)
            .background(Color(red: 0.15, green: 0.15, blue: 0.15))

            Rectangle()
                .fill(Color(red: 0.45, green: 0.45, blue: 0.45))
                .frame(height: 1)
        }
    }
}

struct LambdaInfoView: View {
    var body: some View {
        ZStack {
            Color(red: 0.15, green: 0.15, blue: 0.15) // Gray background
                .ignoresSafeArea() // Extend background to edges

            ScrollView {
                VStack(spacing: 24) {
                    Image("logo3-real")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .padding(.top, 40)

                    Text("About Us")
                        .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                        .font(.largeTitle)
                        .bold()

                    Text("""
                         Lambda is an upcoming project made by highschool students. From Arithmetic, to Trigonometry and even Calculus, Lambda's goal is to provide a free, fun and easy-to-use educational platform for mathematics. Lambda is still a newborn baby in the mobile application environment, but everything starts in 0.
                         
                         Knowledge should be free.
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         """)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .font(.body)
                        .padding(.horizontal)

                    LoopingVideoPlayer(videoName: "UwU", videoType: "mp4")
                        .frame(width: 350, height: 400)
                        .cornerRadius(12)
                }
                .padding(.bottom, 40)
            }
            .scrollContentBackground(.hidden)
        }
    }
}

struct LoopingVideoPlayer: UIViewRepresentable {
    let videoName: String
    let videoType: String

    func makeUIView(context: Context) -> UIView {
        let view = PlayerUIView()
        
        guard let path = Bundle.main.path(forResource: videoName, ofType: videoType) else {
            return view
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        view.playerLayer.player = player
        view.playerLayer.videoGravity = .resizeAspectFill
        
        player.play()
        player.actionAtItemEnd = .none
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem,
                                               queue: .main) { _ in
            player.seek(to: .zero)
            player.play()
        }
        
        return view
    }


    func updateUIView(_ uiView: UIView, context: Context) {}
}




// ✅ Each view uses the custom top bar

struct HomeView: View {
    @State private var bookmarkedCourses: Set<String> = []
    @State private var bookmarkedOrder: [String] = []

    let courses: [(String, AnyView)] = [
        ("Arithmetic", AnyView(ArithmeticView())),
        ("Algebra", AnyView(AlgebraView())),
        ("Geometry", AnyView(ElementalGeometryView())),
        ("Trigonometry", AnyView(TrigonometryView())),
        ("Calculus", AnyView(CalculusView()))
    ]
    var sortedCourses: [(String, AnyView)] {
        let bookmarked = bookmarkedOrder.compactMap { name in
            courses.first(where: { $0.0 == name })
        }
        let unbookmarked = courses.filter { !bookmarkedOrder.contains($0.0) }
        return bookmarked + unbookmarked
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CustomNavigationBar()

                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(sortedCourses, id: \.0) { course in
                            ZStack(alignment: .topTrailing) {
                                NavigationLink(destination: course.1) {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color(red: 0.15, green: 0.15, blue: 0.15))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color(red: 0.3608, green: 0.8784, blue: 0.6118), lineWidth: 2)
                                        )
                                        .frame(height: 120)
                                        .overlay(
                                            VStack(alignment: .leading, spacing: 8) {
                                                Text(course.0)
                                                    .font(.title2)
                                                    .bold()
                                                    .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                                                    .padding(.top, 12)
                                                
                                                VStack(alignment: .leading, spacing: 4) {
                                                    Text("Course completion")
                                                        .font(.caption)
                                                        .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))

                                                    HStack {
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(Color(red: 0.3608, green: 0.8784, blue: 0.6118), lineWidth: 2)
                                                            .frame(width: 150, height: 12)

                                                        Text("0%")
                                                            .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                                                            .font(.caption)
                                                    }
                                                }
                                                .padding(.bottom, 8)
                                            }
                                            .padding(.horizontal, 16)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        )
                                }

                                // ✅ Bookmark Button
                                Button(action: {
                                    if let index = bookmarkedOrder.firstIndex(of: course.0) {
                                        bookmarkedOrder.remove(at: index)
                                    } else {
                                        bookmarkedOrder.insert(course.0, at: 0) // Add to top
                                    }
                                }) {
                                    Image(systemName: bookmarkedOrder.contains(course.0) ? "bookmark.fill" : "bookmark")
                                        .foregroundColor(Color.blue)
                                        .font(.system(size: 22))
                                        .padding(12)
                                }

                                }
                            }
                            .padding(.horizontal)
                        }

                    }
                    .padding(.top)
                }
                .background(Color(red: 0.15, green: 0.15, blue: 0.15))
            }
            .background(Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea())
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }



// Your course detail views (left unchanged)
struct ArithmeticView: View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 4)

    var body: some View {
        VStack(spacing: 0) {
            // Custom top title
            HStack {
                Text("Arithmetic")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 10)

            // Grey line with label
            HStack {
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
                Text("Addition")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .padding(.horizontal, 8)
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
            }
            .padding(.horizontal)

            // Numbered grid
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(1...20, id: \.self) { index in
                        NavigationLink(destination:
                            ZStack {
                                Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea()
                                Text("Detail for item \(index)")
                                    .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                                    .font(.title)
                                    .bold()
                            }
                        ) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red: 0.3608, green: 0.8784, blue: 0.6118), lineWidth: 2)
                                    .frame(height: 60)

                                Text("\(index)")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                        }
                    }
                }

                .padding(.horizontal)
                .padding(.top)
            }
        }
        .background(Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline) // Optional: makes back button behave normally
    }
}



struct AlgebraView: View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 4)

    var body: some View {
        VStack(spacing: 0) {
            // Custom top title
            HStack {
                Text("Algebra")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 10)

            // Grey line with label
            HStack {
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
                Text("Equations with a variable")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 5)
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
            }
            .padding(.horizontal)

            // Numbered grid
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(1...20, id: \.self) { index in
                        NavigationLink(destination:
                            ZStack {
                                Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea()
                                Text("Detail for item \(index)")
                                    .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                                    .font(.title)
                                    .bold()
                            }
                        ) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red: 0.3608, green: 0.8784, blue: 0.6118), lineWidth: 2)
                                    .frame(height: 60)

                                Text("\(index)")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                        }
                    }

                }

                .padding(.horizontal)
                .padding(.top)
            }
        }
        .background(Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline) // Optional: makes back button behave normally
    }
}

struct ElementalGeometryView: View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 4)

    var body: some View {
        VStack(spacing: 0) {
            // Custom top title
            HStack {
                Text("Geometry")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 10)

            // Grey line with label
            HStack {
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
                Text("Elemental Geometry")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 5)
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
            }
            .padding(.horizontal)

            // Numbered grid
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(1...20, id: \.self) { index in
                        NavigationLink(destination:
                            ZStack {
                                Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea()
                                Text("Detail for item \(index)")
                                    .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                                    .font(.title)
                                    .bold()
                            }
                        ) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red: 0.3608, green: 0.8784, blue: 0.6118), lineWidth: 2)
                                    .frame(height: 60)

                                Text("\(index)")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                        }
                    }

                }

                .padding(.horizontal)
                .padding(.top)
            }
        }
        .background(Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline) // Optional: makes back button behave normally
    }
}


struct TrigonometryView: View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 4)

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Trigonometry")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 10)

            // Grey line with label
            HStack {
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
                Text("Trigonometric functions")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 5)
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
            }
            .padding(.horizontal)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(1...20, id: \.self) { index in
                        NavigationLink(destination: destinationView(for: index)) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red: 0.3608, green: 0.8784, blue: 0.6118), lineWidth: 2)
                                    .frame(height: 60)

                                Text("\(index)")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top)
            }
        }
        .background(Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    func destinationView(for index: Int) -> some View {
        if index == 1 {
            ZStack {
                Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea()
                ScrollView {  // Added ScrollView for scrollable content
                    VStack(alignment: .leading, spacing: 20) {  // Increased spacing
                        Text("Module 1: Right triangles")
                            .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                            .font(.title2)
                            .bold()
                            .padding(.top, 20)  // Add top padding
                        
                        Text("Right triangles have three sides named relative to a specific angle: the hypotenuse, the opposite side, and the adjacent side. These names help us describe the triangle’s structure and are essential for understanding how its angles and sides relate to each other.")  // Your existing text
                            .foregroundColor(.white)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Added image with styling
                        Image("RightTriangle")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(12)
                        Text("In the image above, the sides of the right triangle are named relative to the angle θ. The opposite side is the side directly across from the angle θ. The adjacent side is the side next to θ, but it is not the hypotenuse. The hypotenuse is always the longest side and is opposite the right angle, so its name does not change regardless of which angle you reference.")
                            .foregroundColor(.white)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                }
            }
        }
        if index == 2 {
            ZStack {
                Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea()
                ScrollView {  // Added ScrollView for scrollable content
                    VStack(alignment: .leading, spacing: 20) {  // Increased spacing
                        Text("Module 2: Trigonometric functions")
                            .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                            .font(.title2)
                            .bold()
                            .padding(.top, 20)  // Add top padding
                        
                        Text("In the previous module, we saw the existing sides of a right triangle relative to a certain angle. With the reciprocals of said sides, six functions are created, called the Trigonometric functions:")  // Your existing text
                            .foregroundColor(.white)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Added image with styling
                        Image("equation-3")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                        Text("And each of these functions have their respective inverse functions:")
                            .foregroundColor(.white)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Image("equation-2-2")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                }
            }
        }    }

}



struct CalculusView: View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 4)

    var body: some View {
        VStack(spacing: 0) {
            // Custom top title
            HStack {
                Text("Calculus")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 10)

            // Grey line with label
            HStack {
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
                Text("Limits")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 5)
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
            }
            .padding(.horizontal)

            // Numbered grid
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(1...20, id: \.self) { index in
                        NavigationLink(destination:
                            ZStack {
                                Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea()
                                Text("Detail for item \(index)")
                                    .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                                    .font(.title)
                                    .bold()
                            }
                        ) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red: 0.3608, green: 0.8784, blue: 0.6118), lineWidth: 2)
                                    .frame(height: 60)

                                Text("\(index)")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top)
            }
        }
        .background(Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline) // Optional: makes back button behave normally
    }
}

///
//Below are the TabView icons; Home, Forum, Practice, etc.
//Above are the HomeView options
///

struct ForumView: View {
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar()
            ZStack {
                Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea()
                Text("Forum Screen")
                    .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
            }
        }
    }
}

struct PracticeView: View {
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar()
            ZStack {
                Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea()
                Text("Practice Screen")
                    .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
            }
        }
    }
}

struct CombatView: View {
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar()
            ZStack {
                Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea()
                Text("Combat Screen")
                    .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
            }
        }
    }
}

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar()
            ZStack {
                Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea()
                Text("Profile Screen")
                    .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
