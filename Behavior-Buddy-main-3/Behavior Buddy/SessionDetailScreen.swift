import SwiftUI

struct SessionDetailScreen: View {
    @Environment(\.presentationMode) var presentationMode // Added for back button
    let childName: String
    let selectedSession: String
    @State private var navigateToSpeechRecognition = false

    var body: some View {
        ZStack {
            // Updated Background Color
            Color(red: 0.27, green: 0.48, blue: 0.61) // Blue #457B9D
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Back Arrow Button
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding([.leading, .top], 20)

                // Child's Name and "SESSION" Text
                VStack(spacing: 0) {
                    Text(childName)
                        .font(.custom("MarkerFelt-Wide", size: 75)) // Childish Font
                        .foregroundColor(.white)

                    Text("SESSION")
                        .font(.custom("MarkerFelt-Wide", size: 35)) // Childish Font
                        .foregroundColor(.white)
                }

                Spacer().frame(height: 20)

                // Session Box
                HStack {
                    Text("Session:")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray.opacity(0.3)) // Grey background
                        .cornerRadius(8)

                    Text(selectedSession)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(red: 0.92, green: 0.55, blue: 0.55)) // Red #E63946
                        .cornerRadius(8)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 20)

                Spacer().frame(height: 30)

                // Prepare Button
                Button(action: {
                    print("Prepare tapped for \(selectedSession)")
                }) {
                    Text("Prepare")
                        .font(.title)
                        .bold()
                        .frame(width: 300, height: 80)
                        .background(Color(red: 0.92, green: 0.55, blue: 0.55)) // Red #E63946
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                // Start Now Button
                NavigationLink(destination: SpeechRecognitionView(childName: childName, selectedProgram: selectedSession), isActive: $navigateToSpeechRecognition) {
                    Button(action: {
                        navigateToSpeechRecognition = true
                    }) {
                        Text("Start Now")
                            .font(.title)
                            .bold()
                            .frame(width: 300, height: 80)
                            .background(Color(red: 0.92, green: 0.55, blue: 0.55)) // Red #E63946
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct SessionDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        SessionDetailScreen(childName: "Sample Child", selectedSession: "Ball")
    }
}
