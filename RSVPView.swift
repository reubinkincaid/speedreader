import SwiftUI

struct RSVPView: View {
    let word: String
    let isActive: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            // Fixed position RSVP display
            ZStack {
                // Background for the word display
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(radius: 5)
                    .frame(width: 400, height: 100)
                    .opacity(0.9)
                
                if isActive {
                    // Display word with ORP highlighting
                    if word.count > 0 {
                        let orpIndex = calculateORPIndex(word: word)
                        
                        HStack(spacing: 0) {
                            // Characters before ORP
                            ForEach(0..<orpIndex, id: \.self) { index in
                                Text(String(word[word.index(word.startIndex, offsetBy: index)]))
                                    .font(.system(size: 48))
                                    .foregroundColor(.primary)
                            }
                            
                            // ORP character (highlighted in red)
                            if orpIndex < word.count {
                                Text(String(word[word.index(word.startIndex, offsetBy: orpIndex)]))
                                    .font(.system(size: 48, weight: .bold))
                                    .foregroundColor(.red)
                            }
                            
                            // Characters after ORP
                            ForEach(orpIndex+1..<word.count, id: \.self) { index in
                                Text(String(word[word.index(word.startIndex, offsetBy: index)]))
                                    .font(.system(size: 48))
                                    .foregroundColor(.primary)
                            }
                        }
                        .transition(.opacity)
                    }
                }
            }
            .frame(height: 120)
            
            Spacer()
        }
    }
    
    /// Calculate the Optimal Recognition Point for a word
    /// This is typically around the middle of the word for most effective reading
    private func calculateORPIndex(word: String) -> Int {
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
}

struct RSVPView_Previews: PreviewProvider {
    static var previews: some View {
        RSVPView(word: "Reading", isActive: true)
            .frame(width: 500, height: 300)
    }
}