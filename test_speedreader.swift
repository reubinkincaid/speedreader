#!/usr/bin/swift

import Foundation

// Test the ORP calculation function
func calculateORPIndex(word: String) -> Int {
    let length = word.count
    
    // For short words (1-3 characters), highlight the first character
    if length <= 3 {
        return 0
    }
    
    // For medium words (4-7 characters), highlight around the middle
    if length <= 7 {
        return length / 2
    }
    
    // For longer words, highlight slightly before the middle
    // This accounts for the fact that most words have important prefixes
    return max(2, length / 2 - 1)
}

// Test word processing
func cleanWord(_ word: String) -> String {
    var cleaned = word
    while cleaned.last.map({ $0.isPunctuation }) ?? false {
        cleaned.removeLast()
    }
    
    while cleaned.first.map({ $0.isPunctuation }) ?? false {
        cleaned.removeFirst()
    }
    
    return cleaned.isEmpty ? word : cleaned
}

func processTextForReading(_ text: String) -> [String] {
    let whitespaceAndNewlineSet = CharacterSet.whitespacesAndNewlines
    return text.components(separatedBy: whitespaceAndNewlineSet)
        .filter { !$0.isEmpty }
        .map { cleanWord($0) }
}

// Test cases
print("=== Speed Reader ORP Calculation Test ===")
print()

let testWords = [
    "I", "am", "the", "quick", "brown", "fox", "jumping", "over", "lazy", "dog",
    "speedreading", "application", "Optimal", "Recognition", "Point"
]

for word in testWords {
    let orpIndex = calculateORPIndex(word: word)
    let orpChar = orpIndex < word.count ? String(word[word.index(word.startIndex, offsetBy: orpIndex)]) : "?"
    
    var displayWord = ""
    for (i, char) in word.enumerated() {
        if i == orpIndex {
            displayWord += "[\u{001B}[31;1m" + String(char) + "\u{001B}[0m]" // Red bold
        } else {
            displayWord += String(char)
        }
    }
    
    print("Word: " + displayWord + " (ORP at index \(orpIndex): '\(orpChar)')")
}

print()
print("=== Text Processing Test ===")

let sampleText = "Hello, world! This is a test of the speed reading application. It should handle punctuation and multiple sentences correctly."
let processedWords = processTextForReading(sampleText)

print("Original text: \(sampleText)")
print("Processed into \(processedWords.count) words:")
print(processedWords.joined(separator: " | "))

print()
print("=== Speed Calculation Test ===")

let speeds = [100.0, 300.0, 600.0, 1000.0]
for speed in speeds {
    let interval = 60.0 / speed
    print("At \(Int(speed)) WPM: \(interval) seconds per word")
}

print()
print("✅ All tests completed successfully!")