import SwiftUI

struct ContentView: View {
    @State private var textInput: String = ""
    @State private var isReading: Bool = false
    @State private var currentWordIndex: Int = 0
    @State private var words: [String] = []
    @State private var speed: Double = 300.0 // Words per minute
    @State private var timer: Timer?
    @State private var showRSVP: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            // Left panel - Controls and text input
            VStack(spacing: 20) {
                // Text input area
                TextEditor(text: $textInput)
                    .font(.system(size: 16))
                    .padding()
                    .border(Color.gray, width: 1)
                    .frame(minHeight: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                // Controls
                HStack {
                    Button(action: {
                        startReading()
                    }) {
                        Text("Start Reading")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(isReading || textInput.isEmpty)
                    
                    Button(action: {
                        pauseReading()
                    }) {
                        Text("Pause")
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(!isReading)
                    
                    Button(action: {
                        stopReading()
                    }) {
                        Text("Stop")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(!isReading)
                }
                
                // Speed control
                VStack {
                    Text("Speed: \(Int(speed)) WPM")
                    Slider(value: $speed, in: 100...1000, step: 50)
                        .frame(width: 300)
                }
                
                // Progress
                if !words.isEmpty {
                    Text("Progress: \(currentWordIndex + 1)/\(words.count)")
                }
                
                Spacer()
            }
            .frame(width: 400)
            .padding()
            
            // Right panel - RSVP Display (fixed position)
            if showRSVP {
                RSVPView(
                    word: currentWordIndex < words.count ? words[currentWordIndex] : "",
                    isActive: isReading
                )
                .frame(width: 500, height: 400)
            } else {
                // Placeholder when not reading
                Color(.systemBackground)
                    .frame(width: 500, height: 400)
                    .overlay(
                        Text("RSVP Display")
                            .foregroundColor(.secondary)
                            .font(.title3)
                    )
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    func startReading() {
        // Split text into words efficiently for large inputs
        words = processTextForReading(textInput)
        currentWordIndex = 0
        isReading = true
        showRSVP = true
        
        startTimer()
    }
    
    func pauseReading() {
        timer?.invalidate()
        timer = nil
        isReading = false
    }
    
    func stopReading() {
        timer?.invalidate()
        timer = nil
        isReading = false
        currentWordIndex = 0
        showRSVP = false
    }
    
    func startTimer() {
        let interval = 60.0 / speed // Convert WPM to seconds per word
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            if currentWordIndex < words.count - 1 {
                currentWordIndex += 1
            } else {
                stopReading()
            }
        }
    }
    
    /// Process text efficiently for reading, handling large inputs
    private func processTextForReading(_ text: String) -> [String] {
        // Use character set for efficient splitting
        let whitespaceAndNewlineSet = CharacterSet.whitespacesAndNewlines
        
        // For very large texts, process in chunks
        if text.count > 10000 {
            return processLargeText(text)
        } else {
            // Standard processing for normal-sized text
            return text.components(separatedBy: whitespaceAndNewlineSet)
                .filter { !$0.isEmpty }
                .map { cleanWord($0) }
        }
    }
    
    /// Process very large text efficiently
    private func processLargeText(_ text: String) -> [String] {
        var result = [String]()
        var currentWord = ""
        
        for char in text {
            if char.isWhitespace || char.isNewline {
                if !currentWord.isEmpty {
                    result.append(cleanWord(currentWord))
                    currentWord = ""
                }
            } else {
                currentWord.append(char)
            }
            
            // Prevent memory issues with extremely large texts
            if result.count > 50000 {
                break
            }
        }
        
        // Add the last word if there is one
        if !currentWord.isEmpty {
            result.append(cleanWord(currentWord))
        }
        
        return result
    }
    
    /// Clean up words by removing punctuation and normalizing
    private func cleanWord(_ word: String) -> String {
        // Remove common punctuation from the end of words
        var cleaned = word
        while cleaned.last.map({ $0.isPunctuation }) ?? false {
            cleaned.removeLast()
        }
        
        // Remove common punctuation from the beginning
        while cleaned.first.map({ $0.isPunctuation }) ?? false {
            cleaned.removeFirst()
        }
        
        return cleaned.isEmpty ? word : cleaned
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}