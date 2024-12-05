import SwiftUI
import Amplify
import Authenticator
import AWSCognitoAuthPlugin
import AWSAPIPlugin

extension Color {
    static let lightPink = Color(red: 1.0, green: 0.87, blue: 0.87) // Light pink
    static let lightCyan = Color(red: 0.88, green: 1.0, blue: 1.0)   // Light cyan
    static let lightSkyBlue = Color(red: 0.678, green: 1, blue: 1) // Light sky blue
    static let darkSkyBlue = Color(red: 0.0156, green: 0.968, blue: 0.968) // Dark sky blue
    static let customOrange = Color(red: 1.0, green: 0.855, blue: 0.655) // Orange #ffdba7
    static let customRed = Color(red: 0.98, green: 0.502, blue: 0.463) // Red #fa8076
}

@main
struct Behavior_BuddyApp: App {
    init() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
            try Amplify.configure(with: .amplifyOutputs)
        } catch {
            print("Unable to configure Amplify \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
