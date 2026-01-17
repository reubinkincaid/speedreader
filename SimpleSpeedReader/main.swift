#!/usr/bin/swift

import Foundation

print("🚀 SpeedReader - Simple Version")
print(String(repeating: "=", count: 40))
print()

// Simple ORP calculation
func calculateORPIndex(word: String) -> Int {
    let length = word.count
    if length <= 3 { return 0 }
    if length <= 7 { return length / 2 }
    return max(2, length / 2 - 1)
}

// Simple text processing
func processText(_ text: String) -> [String] {
    return text.components(separatedBy: .whitespacesAndNewlines)
        .filter { !$0.isEmpty }
}

// Main reading function
func speedRead(text: String, speed: Int) {
    let words = processText(text)
    guard !words.isEmpty else {
        print("No words to read!")
        return
    }
    
    print("Starting speed reading at \(speed) WPM...")
    print("Total words: \(words.count)")
    print()
    
    let interval = 60.0 / Double(speed)
    
    for (index, word) in words.enumerated() {
        // Clear the line
        print("\u{001B}[2K\r", terminator: "")
        
        // Calculate ORP
        let orpIndex = calculateORPIndex(word: word)
        
        // Display with ORP highlighting
        var displayWord = ""
        for (i, char) in word.enumerated() {
            if i == orpIndex {
                displayWord += "\u{001B}[31;1m" + String(char) + "\u{001B}[0m" // Red bold
            } else {
                displayWord += String(char)
            }
        }
        
        print("Word \(index + 1)/\(words.count): \(displayWord)", terminator: "")
        fflush(stdout)
        
        // Wait for the calculated interval
        Thread.sleep(forTimeInterval: interval)
    }
    
    print()
    print("✅ Reading complete!")
}

// Sample text
let sampleText = "The quick brown fox jumps over the lazy dog. This sentence contains all the letters in the English alphabet. Speed reading can help you process information much faster while maintaining good comprehension."

print("Sample text:")
print(sampleText)
print()

// Start reading
speedRead(text: sampleText, speed: 300)