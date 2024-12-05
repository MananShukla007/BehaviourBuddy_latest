import SwiftUI

struct SpeechRecognitionView: View {
    let childName: String
    let selectedProgram: String
    @Environment(\.presentationMode) var presentationMode
    @State private var sessionCount: Int = 0
    @State private var timeRemaining = 180 // 03:00 in seconds
    @State private var isTimerRunning = false
    @State private var showMessage: String? = nil
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            // Background Color
            Color(red: 0.27, green: 0.48, blue: 0.61) // Blue #457B9D
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Back Button at Top Left
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // Dynamic Message Box at the Top
                if let message = showMessage {
                    Text(message)
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(red: 0.92, green: 0.55, blue: 0.55)) // Updated button color
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.3)) // Grey box
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }

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

                // Program and Session Boxes
                VStack(spacing: 15) {
                    // Program Box
                    HStack {
                        Text("Program:")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray.opacity(0.3)) // Grey background
                            .cornerRadius(8)

                        Text(selectedProgram)
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(red: 0.92, green: 0.55, blue: 0.55)) // Updated button color
                            .cornerRadius(8)
                            .shadow(radius: 5)
                    }

                    // Session Count Box
                    HStack {
                        Text("Session:")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray.opacity(0.3)) // Grey background
                            .cornerRadius(8)

                        Text("\(sessionCount)")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(red: 0.92, green: 0.55, blue: 0.55)) // Updated button color
                            .cornerRadius(8)
                            .shadow(radius: 5)
                    }
                }
                .padding(.horizontal, 20)

                Spacer().frame(height: 30)

                // Timer Box
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.gray.opacity(0.3)) // Grey background
                        .frame(width: 300, height: 100)
                    Text(timeString(from: timeRemaining))
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                }

                Spacer()

                // Start and End Buttons
                HStack(spacing: 40) {
                    Button(action: {
                        startTimer()
                    }) {
                        Text("Start")
                            .font(.title)
                            .bold()
                            .frame(width: 150, height: 60)
                            .background(Color(red: 0.92, green: 0.55, blue: 0.55)) // Updated button color
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button(action: {
                        stopTimer()
                    }) {
                        Text("End")
                            .font(.title)
                            .bold()
                            .frame(width: 150, height: 60)
                            .background(Color(red: 0.92, green: 0.55, blue: 0.55)) // Updated button color
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }

                Spacer()
            }
            .padding()
            .onAppear {
                // Load and increment the session count
                sessionCount = UserDefaults.standard.integer(forKey: "sessionCount_\(selectedProgram)") + 1
                UserDefaults.standard.set(sessionCount, forKey: "sessionCount_\(selectedProgram)")
            }
            .onReceive(timer) { _ in
                if isTimerRunning && timeRemaining > 0 {
                    timeRemaining -= 1

                    // Show "30 seconds remaining" message
                    if timeRemaining == 30 {
                        showTemporaryMessage("!! 30 Seconds Remaining !!")
                    }

                    // End session automatically if timer hits zero
                    if timeRemaining == 0 {
                        stopTimer()
                        showTemporaryMessage("Session Ended")
                    }
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }

    private func startTimer() {
        isTimerRunning = true
        timeRemaining = 180 // Reset timer to 03:00
        showTemporaryMessage("Session Started")
    }

    private func stopTimer() {
        isTimerRunning = false
        showTemporaryMessage("Session Ended")
    }

    private func showTemporaryMessage(_ message: String) {
        showMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showMessage = nil
        }
    }

    private func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct SpeechRecognitionView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechRecognitionView(childName: "Sample Child", selectedProgram: "Ball")
    }
}
