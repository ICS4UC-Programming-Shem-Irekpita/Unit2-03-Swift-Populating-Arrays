/*
 * Created by: Shem
 * Created on: Oct, 10, 2026
 * Generates an array of 10 random integers (0 to 100),
 * displays them on one line, then sorts the array with
 * .sort(), calculates the average, and displays the
 * sorted array and average. This process is repeated 5 times.
 */

import Foundation

/// Utility namespace for populating arrays and calculating averages.
enum PopulatingArrays {

    /// Input file path constant.
    static let inputFile = "input.txt"

    /// Output file path constant.
    static let outputFile = "output.txt"

    /// Appends text to a specified file.
    ///
    /// - Parameters:
    ///   - fileName: The target file path.
    ///   - text: The content to append.
    /// - Throws: An error if an I/O operation fails.
    static func appendLine(fileName: String, text: String) throws {
        let fileURL = URL(fileURLWithPath: fileName)
        let line = text + "\n"
        guard let data = line.data(using: .utf8) else { return }

        if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
            defer {
                try? fileHandle.close()
            }
            try fileHandle.seekToEnd()
            try fileHandle.write(contentsOf: data)
        } else {
            try line.write(to: fileURL, atomically: true, encoding: .utf8)
        }
    }

    /// Populates an array with 10 random integers from 0 to 100.
    ///
    /// - Returns: An array of 10 random integers.
    /// - Throws: An error if an I/O operation fails.
    static func populateArray() throws -> [Int] {
        var numbers = [Int]()
        for _ in 0..<10 {
            numbers.append(Int.random(in: 0...100))
        }

        let text = numbers.map(String.init).joined(separator: " ")
        print(text)
        try appendLine(fileName: inputFile, text: text)
        return numbers
    }

    /// Sorts array, calculates average, and writes to output file.
    ///
    /// - Parameter numbers: The array of integers to process.
    /// - Throws: An error if an I/O operation fails.
    static func calculateAverage(numbers: [Int]) throws {
        var sortedNumbers = numbers
        sortedNumbers.sort()

        let sum = sortedNumbers.reduce(0, +)
        let line = sortedNumbers.map(String.init).joined(separator: " ")
        let average = Double(sum) / Double(sortedNumbers.count)

        let text = String(format: "%@  Average:  %.1f", line, average)
        print(text)
        try appendLine(fileName: outputFile, text: text)
    }

    /// Main entry point of the program.
    static func main() {
        do {
            // Clear or reset input and output files
            try "".write(toFile: inputFile, atomically: true, encoding: .utf8)
            try "".write(toFile: outputFile, atomically: true, encoding: .utf8)

            for _ in 0..<5 {
                let numbers = try populateArray()
                try calculateAverage(numbers: numbers)
            }
        } catch {
            print("File error: \(error.localizedDescription)")
        }
    }
}

// Execute the program
PopulatingArrays.main()