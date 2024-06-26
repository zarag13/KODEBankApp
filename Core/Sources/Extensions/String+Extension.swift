//
//  String+Extension.swift
//  Core
//
//  Created by Kirill on 25.04.2024.
//

import Foundation

extension String {
    public func maskPhoneNumber(pattern: String) -> String {
        var inputCollection = Array(self)
        var resultCollection = [Character]()
        for i in 0 ..< pattern.count {
            let patternCharIndex = String.Index(utf16Offset: i, in: pattern)
            let patternChar = pattern[patternCharIndex]
            guard let nextInputChar = inputCollection.first else { break }
            if patternChar == nextInputChar || patternChar == "#" {
                resultCollection.append(nextInputChar)
                inputCollection.removeFirst()
            } else {
                resultCollection.append(patternChar)
            }
        }
        return String(resultCollection)
    }

    public func maskEnterPhoneNumber(pattern: String) -> String {
        var startString = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var inputCollection = Array(startString)
        var resultCollection = [Character]()
        for i in 0 ..< pattern.count {
            let patternCharIndex = String.Index(utf16Offset: i, in: pattern)
            let patternChar = pattern[patternCharIndex]
            guard let nextInputChar = inputCollection.first else { break }
            if patternChar == nextInputChar || patternChar == "#" {
                resultCollection.append(nextInputChar)
                inputCollection.removeFirst()
            } else {
                resultCollection.append(patternChar)
            }
        }
        return String(resultCollection)
    }
}
