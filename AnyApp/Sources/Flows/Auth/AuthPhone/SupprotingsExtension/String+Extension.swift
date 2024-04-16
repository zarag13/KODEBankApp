//
//  String+Extension.swift
//  AnyApp
//
//  Created by Kirill on 16.04.2024.
//

import Foundation

extension String {
    func formatUserInput(pattern: String) -> String {
        var inputCollection = Array(self)
        var resultCollection = [Character]()
        for i in 0 ..< pattern.count {
            let patternCharIndex = String.Index(utf16Offset: i, in: pattern)
            let patternChar = pattern[patternCharIndex]
            guard let nextInputChar = inputCollection.first else { break }
            if (patternChar == nextInputChar || patternChar == "#") {
                resultCollection.append(nextInputChar)
                inputCollection.removeFirst()
            } else {
                resultCollection.append(patternChar)
            }
        }
        return String(resultCollection)
    }
}
