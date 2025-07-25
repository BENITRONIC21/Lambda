//
//  ContentView.swift
//  Lambda
//
//  Created by Benito Antuñano Idargo on 05/06/25.
//

// Colors:
//
// Mint green:    Color(red: 0.3608, green: 0.8784, blue: 0.6118)
//
// Dark gray:     Color(red: 0.45, green: 0.45, blue: 0.45)
//
// Gray:          .gray
//
// White:         .white

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

//MARK: Blackboard
import SwiftUI

enum ToolMode {
    case move, draw, postIt
}

enum BlackboardElement {
    case path(ColoredPath)
    case postIt(PostIt)
}

struct PostIt: Identifiable {
    let id = UUID()
    var position: CGPoint
    var color: Color
    var text: String
}

struct ColoredPath: Identifiable {
    let id = UUID()
    let path: Path
    let color: Color
}

struct BlackboardView: View {
    @State private var mode: ToolMode = .move
    @State private var paths: [ColoredPath] = []
    @State private var currentPath = Path()
    @State private var currentPathColor: Color = .white
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var pencilColor: Color = .white
    @State private var postItColor: Color = .yellow
    @State private var postIts: [PostIt] = []
    @State private var elementStack: [BlackboardElement] = []

    @GestureState private var gestureOffset: CGSize = .zero
    @GestureState private var varGestureScale: CGFloat = 1.0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0.15, green: 0.15, blue: 0.15)
                    .ignoresSafeArea()

                CanvasWrapper {
                    canvasView
                        .scaleEffect(scale * varGestureScale)
                        .offset(x: offset.width + gestureOffset.width, y: offset.height + gestureOffset.height)
                        .gesture(mainCanvasGesture)
                        .simultaneousGesture(postItPlacementGesture(in: geometry.size))
                }

                VStack(alignment: .leading, spacing: 12) {
                    ToolButton(icon: "hand.tap", isSelected: mode == .move) {
                        mode = .move
                    }
                    ToolButton(icon: "pencil", isSelected: mode == .draw) {
                        mode = .draw
                        currentPathColor = pencilColor
                    }
                    ColorPicker("", selection: $pencilColor)
                        .labelsHidden()
                        .frame(width: 36, height: 36)

                    ToolButton(icon: "note.text", isSelected: mode == .postIt) {
                        mode = .postIt
                    }
                    ColorPicker("", selection: $postItColor)
                        .labelsHidden()
                        .frame(width: 36, height: 36)

                    ToolButton(icon: "arrow.uturn.backward") {
                        guard let last = elementStack.popLast() else { return }
                        switch last {
                        case .path(let pathToRemove):
                            if let index = paths.firstIndex(where: { $0.id == pathToRemove.id }) {
                                paths.remove(at: index)
                            }
                        case .postIt(let postItToRemove):
                            if let index = postIts.firstIndex(where: { $0.id == postItToRemove.id }) {
                                postIts.remove(at: index)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.black)
                .cornerRadius(12)
                .padding(.leading)
                .padding(.top, 60)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Blackboard")
                        .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                        .font(.headline)
                        .bold()
                }
            }
        }
        .onChange(of: pencilColor) { newColor in
            if mode == .draw {
                currentPathColor = newColor
            }
        }
    }

    var canvasView: some View {
        ZStack {
            DotGridView()
            ForEach(paths) { coloredPath in
                coloredPath.path.stroke(coloredPath.color, lineWidth: 2)
            }
            currentPath.stroke(currentPathColor, lineWidth: 2)

            ForEach(postIts) { postIt in
                PostItView(postIt: postIt, onUpdate: { updated in
                    if let index = postIts.firstIndex(where: { $0.id == updated.id }) {
                        postIts[index] = updated
                    }
                })
                .position(postIt.position)
            }
        }
        .contentShape(Rectangle())
    }

    struct PostItView: View {
        @State var postIt: PostIt
        var onUpdate: (PostIt) -> Void
        @FocusState private var isFocused: Bool
        let singlePostItHeight: CGFloat = 120.0

        var body: some View {
            ZStack {
                TextField("Note", text: $postIt.text, axis: .vertical)
                    .font(.system(size: 12))
                    .padding(8)
                    .background(postIt.color)
                    .cornerRadius(8)
            }
            .frame(width: 120, height: singlePostItHeight * 4)
            .fixedSize(horizontal: false, vertical: true)
            .focused($isFocused)
            .onAppear {
                isFocused = true
            }
            .onChange(of: postIt.text) { _ in
                onUpdate(postIt)
            }
        }
    }

    var mainCanvasGesture: some Gesture {
        DragGesture(minimumDistance: mode == .draw ? 0.1 : 0)
            .updating($gestureOffset) { value, state, _ in
                if mode == .move {
                    state = value.translation
                }
            }
            .onChanged { value in
                if mode == .draw {
                    let point = CGPoint(
                        x: (value.location.x - offset.width) / scale,
                        y: (value.location.y - offset.height) / scale
                    )
                    if currentPath.isEmpty {
                        currentPath.move(to: point)
                    } else {
                        currentPath.addLine(to: point)
                    }
                }
            }
            .onEnded { value in
                if mode == .move {
                    offset.width += value.translation.width
                    offset.height += value.translation.height
                } else if mode == .draw {
                    let newPath = ColoredPath(path: currentPath, color: currentPathColor)
                    paths.append(newPath)
                    elementStack.append(.path(newPath))
                    currentPath = Path()
                }
            }
            .simultaneously(with: MagnificationGesture()
                .updating($varGestureScale) { value, state, _ in
                    if mode == .move {
                        state = value
                    }
                }
                .onEnded { value in
                    if mode == .move {
                        scale *= value
                    }
                }
            )
    }

    func postItPlacementGesture(in size: CGSize) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onEnded { value in
                guard mode == .postIt else { return }
                let transformed = CGPoint(
                    x: (value.location.x - offset.width) / scale,
                    y: (value.location.y - offset.height) / scale
                )
                let newPostIt = PostIt(position: transformed, color: postItColor, text: "")
                postIts.append(newPostIt)
                elementStack.append(.postIt(newPostIt))
            }
    }
}

struct ToolButton: View {
    let icon: String
    var isSelected: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 36, height: 36)
                .background(isSelected ? Color.green : Color.black)
                .cornerRadius(8)
        }
    }
}

struct DotGridView: View {
    let spacing: CGFloat = 20

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for x in stride(from: 0, to: geometry.size.width, by: spacing) {
                    for y in stride(from: 0, to: geometry.size.height, by: spacing) {
                        path.addEllipse(in: CGRect(x: x, y: y, width: 2, height: 2))
                    }
                }
            }
            .fill(Color.gray.opacity(0.3))
        }
    }
}

struct CanvasWrapper<Content: View>: View {
    let content: () -> Content

    var body: some View {
        GeometryReader { geo in
            ScrollView([.horizontal, .vertical], showsIndicators: false) {
                content()
                    .frame(width: 5000, height: 5000)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
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
                        Text("And each of these functions have their respective reciprocal functions:")
                            .foregroundColor(.white)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Image("equation-2-2")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                        Text("Trigonometric functions allow us to calculate sides, angles, and other properties in geometry. They also appear naturally in the real world in the form of waves-like sound waves")
                            .foregroundColor(.white)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
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
import SwiftUI

// Make sure your Post model looks like this:
struct Post: Identifiable {
    let id = UUID()
    var title: String
    var content: String
    var postType: String
    var category: String
}

struct ForumView: View {
    @State private var selectedCategory: String = "All posts"
    @State private var posts: [Post] = []

    let categories = ["All posts", "Problems", "Discussions"]

    var filteredPosts: [Post] {
        switch selectedCategory {
        case "Problems":
            return posts.filter { $0.postType == "Problem" }
        case "Discussions":
            return posts.filter { $0.postType == "Discussion" }
        default:
            return posts
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CustomNavigationBar()

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Header + Create post button
                        HStack {
                            Text("Forum")
                                .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                                .font(.title)
                                .bold()

                            Spacer()

                            NavigationLink(destination: CreatePostView(posts: $posts)) {
                                Text("Create post +")
                                    .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)

                        // Selector bar
                        HStack(spacing: 0) {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    selectedCategory = category
                                }) {
                                    Text(category)
                                        .foregroundColor(selectedCategory == category
                                                         ? Color(red: 0.3608, green: 0.8784, blue: 0.6118)
                                                         : Color.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 10)
                                }
                            }
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 0.3608, green: 0.8784, blue: 0.6118), lineWidth: 2)
                        )
                        .padding(.horizontal)

                        // Posts list with newest first
                        VStack(spacing: 12) {
                            ForEach(Array(filteredPosts.reversed()), id: \.id) { post in
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(post.title)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        Text(post.content)
                                            .foregroundColor(.gray)
                                            .lineLimit(2)
                                    }
                                    Spacer()
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(red: 0.18, green: 0.18, blue: 0.18))
                                )
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top, 8)
                    }
                    .padding(.bottom, 20)
                }
                .background(Color(red: 0.15, green: 0.15, blue: 0.15))
            }
            .background(Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CreatePostView: View {
    @Environment(\.dismiss) var dismiss

    @Binding var posts: [Post]

    @State private var title: String = ""
    @State private var content: String = ""

    @State private var selectedPostType = "Post"
    @State private var selectedCategory = "N/A"

    let postTypes = ["Post", "Problem", "Discussion"]
    let categories = ["N/A", "Arithmetic", "Algebra", "Geometry", "Trigonometry", "Calculus"]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TextField("Title", text: $title)
                .padding()
                .foregroundColor(.white)
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 0.3608, green: 0.8784, blue: 0.6118), lineWidth: 2)
                )

            // Post type picker
            Picker("Post Type", selection: $selectedPostType) {
                ForEach(postTypes, id: \.self) { type in
                    Text(type).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            // Category picker
            Picker("Category", selection: $selectedCategory) {
                ForEach(categories, id: \.self) { category in
                    Text(category).tag(category)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal)

            TextEditor(text: $content)
                .frame(height: 200)
                .padding()
                .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 0.3608, green: 0.8784, blue: 0.6118), lineWidth: 2)
                )

            Spacer()

            Button(action: {
                let newPost = Post(
                    title: title,
                    content: content,
                    postType: selectedPostType,
                    category: selectedCategory
                )
                posts.append(newPost)
                dismiss()
            }) {
                Text("Post")
                    .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        .navigationTitle("New Post")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("New Post")
                    .font(.headline)
                    .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
            }

            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(.red)
            }
        }
    }
}


import SwiftUI

struct MathExercise {
    let question: String
    let answer: String
}

class ExerciseGenerator {
    func generate(for branch: String) -> MathExercise {
        switch branch {
        case "Arithmetic":
            return [add, subtract, multiply, divide].randomElement()!()
        case "Algebra":
            return [solveForX, expandBinomial].randomElement()!()
        case "Geometry":
            return [areaOfSquare, areaOfTriangle, perimeterOfRectangle].randomElement()!()
        case "Trigonometry":
            return [basicTrig, pythagorean].randomElement()!()
        case "Calculus":
            return [derivative, integral].randomElement()!()
        default:
            return MathExercise(question: "No branch selected.", answer: "")
        }
    }

    // MARK: - Arithmetic
    private func add() -> MathExercise {
        let a = Int.random(in: 1...50)
        let b = Int.random(in: 1...50)
        return MathExercise(question: "\(a) + \(b) = ?", answer: "\(a + b)")
    }

    private func subtract() -> MathExercise {
        let a = Int.random(in: 20...100)
        let b = Int.random(in: 1...20)
        return MathExercise(question: "\(a) − \(b) = ?", answer: "\(a - b)")
    }

    private func multiply() -> MathExercise {
        let a = Int.random(in: 1...12)
        let b = Int.random(in: 1...12)
        return MathExercise(question: "\(a) × \(b) = ?", answer: "\(a * b)")
    }

    private func divide() -> MathExercise {
        let b = Int.random(in: 1...10)
        let a = b * Int.random(in: 1...10)
        return MathExercise(question: "\(a) ÷ \(b) = ?", answer: "\(a / b)")
    }

    // MARK: - Algebra
    private func solveForX() -> MathExercise {
        let x = Int.random(in: 1...10)
        let a = Int.random(in: 1...10)
        let b = x * a
        return MathExercise(question: "\(a)x = \(b). What is x?", answer: "\(x)")
    }

    private func expandBinomial() -> MathExercise {
        let a = Int.random(in: 1...5)
        let b = Int.random(in: 1...5)
        let question = "Expand: (x + \(a))(x + \(b))"
        let answer = "x² + \(a + b)x + \(a * b)"
        return MathExercise(question: question, answer: answer)
    }

    // MARK: - Geometry
    private func areaOfSquare() -> MathExercise {
        let s = Int.random(in: 1...15)
        return MathExercise(question: "Area of a square with side \(s)?", answer: "\(s * s)")
    }

    private func areaOfTriangle() -> MathExercise {
        let b = Int.random(in: 1...10)
        let h = Int.random(in: 1...10)
        return MathExercise(question: "Area of triangle with base \(b) and height \(h)?", answer: "\((b * h) / 2)")
    }

    private func perimeterOfRectangle() -> MathExercise {
        let l = Int.random(in: 1...10)
        let w = Int.random(in: 1...10)
        return MathExercise(question: "Perimeter of a rectangle \(l)×\(w)?", answer: "\(2 * (l + w))")
    }

    // MARK: - Trigonometry
    private func basicTrig() -> MathExercise {
        return MathExercise(question: "What is cos(0°)?", answer: "1")
    }

    private func pythagorean() -> MathExercise {
        let a = Int.random(in: 3...10)
        let b = Int.random(in: 3...10)
        let c = Int(sqrt(Double(a * a + b * b)))
        return MathExercise(question: "If a = \(a), b = \(b), find hypotenuse c.", answer: "\(c)")
    }

    // MARK: - Calculus
    private func derivative() -> MathExercise {
        let n = Int.random(in: 2...5)
        return MathExercise(question: "d/dx of x^\(n) is...?", answer: "\(n)x^\(n - 1)")
    }

    private func integral() -> MathExercise {
        let n = Int.random(in: 1...4)
        return MathExercise(question: "∫x^\(n) dx = ?", answer: "x^\(n + 1)/\(n + 1) + C")
    }
}

struct PracticeView: View {
    @State private var selectedBranch: String = "Choose branch"
    @State private var currentExercise: MathExercise?
    @State private var userAnswer: String = ""
    @State private var feedback: String = ""

    let branches = ["Arithmetic", "Algebra", "Geometry", "Trigonometry", "Calculus"]
    let generator = ExerciseGenerator()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CustomNavigationBar()

                ScrollView {
                    VStack(spacing: 20) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(red: 0.15, green: 0.15, blue: 0.15))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 0.3608, green: 0.8784, blue: 0.6118), lineWidth: 2)
                            )
                            .frame(height: 600)
                            .overlay(
                                VStack(alignment: .leading, spacing: 16) {
                                    Text("Exercise generator")
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                                        .padding(.top, 12)

                                    Menu {
                                        ForEach(branches, id: \.self) { branch in
                                            Button(action: {
                                                selectedBranch = branch
                                            }) {
                                                Text(branch)
                                            }
                                        }
                                    } label: {
                                        HStack {
                                            Text(selectedBranch)
                                                .foregroundColor(.gray)
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                                .foregroundColor(.gray)
                                        }
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color(red: 0.3608, green: 0.8784, blue: 0.6118), lineWidth: 2)
                                        )
                                    }

                                    if selectedBranch != "Choose branch" {
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                                currentExercise = generator.generate(for: selectedBranch)
                                                userAnswer = ""
                                                feedback = ""
                                            }) {
                                                Text("Generate exercise")
                                                    .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15))
                                                    .fontWeight(.bold)
                                                    .padding()
                                                    .frame(width: 315)
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .fill(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                                                    )
                                            }
                                            Spacer()
                                        }
                                        .transition(.opacity)
                                    }

                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color(red: 0.3608, green: 0.8784, blue: 0.6118), lineWidth: 2)
                                            .frame(height: 200)

                                        VStack(spacing: 12) {
                                            if let exercise = currentExercise {
                                                Text(exercise.question)
                                                    .foregroundColor(.white)
                                                    .font(.headline)

                                                TextField("Your answer", text: $userAnswer)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .keyboardType(.default)

                                                Button("Check Answer") {
                                                    if userAnswer.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                                                        == exercise.answer.lowercased() {
                                                        feedback = "✅ Correct!"
                                                    } else {
                                                        feedback = "❌ Incorrect. Answer: \(exercise.answer)"
                                                    }
                                                }
                                                .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15))
                                                .padding(.horizontal)
                                                .padding(.vertical, 8)
                                                .background(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                                                .cornerRadius(8)

                                                Text(feedback)
                                                    .foregroundColor(.gray)
                                                    .font(.subheadline)
                                            } else {
                                                Text("Your exercise will be generated here.")
                                                    .foregroundColor(.gray)
                                                    .font(.headline)
                                            }
                                        }
                                        .padding()
                                    }

                                    HStack {
                                        Spacer()
                                        NavigationLink(destination: BlackboardView()) {
                                            Text("Open Blackboard")
                                                .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15))
                                                .padding()
                                                .background(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                                                .cornerRadius(10)
                                        }
                                        Spacer()
                                    }
                                    .padding(.top, 10)

                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            )
                            .padding(.horizontal)
                    }
                    .padding(.top)
                }
                .background(Color(red: 0.15, green: 0.15, blue: 0.15))
            }
            .background(Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CombatView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CustomNavigationBar()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // 🛡️ Combat Card
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 0.15, green: 0.15, blue: 0.15))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(red: 0.3608, green: 0.8784, blue: 0.6118), lineWidth: 2)
                                )

                            VStack(spacing: 24) {
                                Spacer().frame(height: 30)

                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.white.opacity(0.1))
                                        .frame(width: 100, height: 100)

                                    Image(systemName: "shield.lefthalf.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                                }

                                Text("Challenge yourself in a fast-paced math battle! Solve problems quickly to win.")
                                    .font(.body)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)

                                Button(action: {
                                    print("Combat started!")
                                }) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                                        .frame(height: 50)
                                        .overlay(
                                            Text("Combat")
                                                .fontWeight(.bold)
                                                .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15))
                                        )
                                }
                                .padding(.horizontal, 60)

                                Spacer().frame(height: 30)
                            }
                            .padding()
                        }
                        .padding(.horizontal)

                        // 🏆 Leaderboard Card
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 0.15, green: 0.15, blue: 0.15))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(red: 0.3608, green: 0.8784, blue: 0.6118), lineWidth: 2)
                                )

                            VStack(alignment: .leading, spacing: 12) {
                                Text("Leaderboard")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                                    .padding(.bottom, 4)

                                ForEach(1...10, id: \.self) { index in
                                    HStack {
                                        Text("\(index). User\(index)")
                                        Spacer()
                                        Text("0 pts")
                                    }
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 4)
                                }
                            }
                            .padding()
                        }
                        .padding(.horizontal)

                        Spacer().frame(height: 30)
                    }
                    .padding(.top)
                }
                .background(Color(red: 0.15, green: 0.15, blue: 0.15))

                .background(Color(red: 0.15, green: 0.15, blue: 0.15))
            }
            .background(Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}




import SwiftUI

struct ProfileView: View {
    @State private var username: String = "Grigori P."
    @State private var email: String = "grigorip2002@gmail.com"
    @State private var instagram: String = "Instagram"
    @State private var youtube: String = "Youtube"
    @State private var facebook: String = "Facebook"
    @State private var showSettings = false
    @State private var problemsSolved: Int = 67
    @State private var combatWins: Int = 67
    @State private var friendsCount: Int = 67
    @State private var profileImage: Image? = Image("user_avatar")

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CustomNavigationBar() // Assuming you defined this elsewhere

                ScrollView {
                    VStack(spacing: 20) {
                        ZStack(alignment: .topTrailing) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 0.15, green: 0.15, blue: 0.15))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(red: 0.3608, green: 0.8784, blue: 0.6118), lineWidth: 2)
                                )
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)

                            VStack(spacing: 16) {
                                (profileImage ?? Image("user_avatar"))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color(red: 0.3608, green: 0.8784, blue: 0.6118), lineWidth: 3)
                                    )
                                    .shadow(radius: 5)

                                Text(username)
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.white)

                                Text(email)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                Divider()
                                    .background(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                                    .padding(.horizontal)

                                HStack(spacing: 0) {
                                    Spacer()
                                    StatView(label: "Problems Solved", value: "\(problemsSolved)")
                                    Spacer()
                                    StatView(label: "Combat Wins", value: "\(combatWins)")
                                    Spacer()
                                    StatView(label: "Friends", value: "\(friendsCount)")
                                    Spacer()
                                }
                                .padding(.vertical, 8)
                            }
                            .padding()
                        }
                        .overlay(
                            Button(action: {
                                showSettings.toggle()
                            }) {
                                Image(systemName: "gearshape.fill")
                                    .font(.title2)
                                    .padding()
                                    .foregroundColor(Color(red: 0.3608, green: 0.8784, blue: 0.6118))
                            }
                            .padding(.trailing, 40)
                            .padding(.top, 20),
                            alignment: .topTrailing
                        )

                        Spacer(minLength: 30)
                    }
                    .padding(.top)
                }
                .background(Color(red: 0.15, green: 0.15, blue: 0.15))
            }
            .background(Color(red: 0.15, green: 0.15, blue: 0.15).ignoresSafeArea())
            .sheet(isPresented: $showSettings) {
                SettingsSheet(
                    isPresented: $showSettings,
                    username: $username,
                    email: $email,
                    instagram: $instagram,
                    youtube: $youtube,
                    facebook: $facebook,
                    profileImage: $profileImage
                )
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}



import SwiftUI
import UIKit

struct SettingsSheet: View {
    @Binding var isPresented: Bool
    @Binding var username: String
    @Binding var email: String
    @Binding var instagram: String
    @Binding var youtube: String
    @Binding var facebook: String
    @Binding var profileImage: Image?

    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {

                    VStack(spacing: 16) {
                        profileTextField(title: "Username", text: $username)
                        profileTextField(title: "Email", text: $email)
                        profileTextField(title: "Instagram", text: $instagram)
                        profileTextField(title: "YouTube", text: $youtube)
                        profileTextField(title: "Facebook", text: $facebook)
                    }
                    .padding()
                    .background(Color(red: 0.25, green: 0.25, blue: 0.25))
                    .cornerRadius(20)

                    VStack(spacing: 16) {
                        Text("Profile Picture")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.36, green: 0.87, blue: 0.61))

                        if let image = profileImage {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(radius: 8)
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .foregroundColor(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(radius: 8)
                        }

                        Button("Change Picture") {
                            showingImagePicker = true
                        }
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.36, green: 0.87, blue: 0.61))
                        .cornerRadius(10)
                    }
                    .padding()
                    .background(Color(red: 0.25, green: 0.25, blue: 0.25))
                    .cornerRadius(20)
                }
                .padding()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        isPresented = false
                    }
                }
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
            .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        }
    }

    func profileTextField(title: String, text: Binding<String>) -> some View {
        TextField("", text: text)
            .foregroundColor(.white)
            .padding()
            .background(Color(red: 0.2, green: 0.2, blue: 0.2))
            .cornerRadius(8)
            .disableAutocorrection(true)
            .autocapitalization(.none)
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }
}

// MARK: - Placeholder Extension

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow {
                placeholder()
            }
            self
        }
    }
}

// MARK: - Image Picker

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}


// MARK: - Stat View

import SwiftUI

struct StatView: View {
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.headline)
                .bold()
                .foregroundColor(.white)
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
