import SwiftUI

struct ContentView: View {
    @State private var textInput: String = ""
    @State private var isReading: Bool = false
    @State private var currentWordIndex: Int = 0
    @State private var words: [String] = []
    @State private var speed: Double = 300.0
    @State private var timer: Timer?
    @State private var showRSVP: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            RSVPView(
                word: currentWordIndex < words.count ? words[currentWordIndex] : "",
                isActive: isReading || showRSVP
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack(spacing: 12) {
                HStack(spacing: 8) {
                    Button(action: startReading) {
                        Text("Start")
                            .font(.system(size: 12))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(6)
                    }
                    .disabled(isReading || textInput.isEmpty)
                    
                    Button(action: pauseReading) {
                        Text("Pause")
                            .font(.system(size: 12))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8))
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(6)
                    }
                    .disabled(!isReading)
                    
                    Button(action: stopReading) {
                        Text("Stop")
                            .font(.system(size: 12))
                            .padding(.horizontal, 16))
                            .padding(.vertical, 8))
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(6)
                    }
                    .disabled(!isReading)
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        Text("\(Int(speed)) WPM")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                            .frame(width: 70, alignment: .trailing)
                        
                        Slider(value: $speed, in: 100...1000, step: 50)
                            .frame(width: 120)
                    }
                }
                
                if !words.isEmpty {
                    Text("\(currentWordIndex + 1)/\(words.count)")
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(Color(NSColor.controlBackgroundColor))
            
            TextEditor(text: $textInput)
                .font(.system(size: 14, design: .serif))
                .padding()
                .frame(height: 150)
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    func startReading() {
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
        let interval = 60.0 / speed
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            if currentWordIndex < words.count - 1 {
                currentWordIndex += 1
            } else {
                stopReading()
            }
        }
    }
    
    private func processTextForReading(_ text: String) -> [String] {
        let whitespaceAndNewlineSet = CharacterSet.whitespacesAndNewlines
        
        if text.count > 10000 {
            return processLargeText(text)
        } else {
            return text.components(separatedBy: whitespaceAndNewlineSet)
                .filter { !$0.isEmpty }
                .map { cleanWord($0) }
        }
    }
    
    private func processLargeText(_ text: String) -> [String] {
        var result = [String]()
        var currentWord = ""
        
        for char in text {
            if char.isWhitespace || char.isNewline {
                if !currentWord.isEmpty {
                    result.append(cleanWord(currentWord))
                }
                currentWord = ""
            } else {
                currentWord.append(char)
                
                if result.count > 50000 {
                    break
                }
            }
        
        if !currentWord.isEmpty {
            result.append(cleanWord(currentWord))
        }
        
        return result
    }
    
    private func cleanWord(_ word: String) -> String {
        var cleaned = word
        while cleaned.last.map({ $0.isPunctuation }) ?? false {
            cleaned.removeLast()
        }
        
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
