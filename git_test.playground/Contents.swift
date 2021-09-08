import Foundation
import PlaygroundSupport

func canReduce(_ elem: String, _ last: String) -> Bool {
    switch (elem, last) {
        case ("TOP", "BOTTOM") : return true
        case ("TOP", "TOP") : return true
        case ("BOTTOM", "BOTTOM") : return true
        case ("BOTTOM", "TOP") : return true
        case ("LEFT", "RIGHT") : return true
        case ("LEFT", "LEFT") : return true
        case ("RIGHT", "RIGHT") : return true
        case ("RIGHT", "LEFT") : return true
        default: return false
    }
}

let url = playgroundSharedDataDirectory.appendingPathComponent("input.txt")
let fileName = "input.txt"

func readNums() {
    guard let line = try? String(contentsOfFile: fileName) else {
        print("oopsie")
        return
    }
    print("hey")
    let directions = line.components(separatedBy: "\n")
    var reduced = [(String, Int)]()
    
    for direction in directions {
        let parts = direction.split(separator: " ")
        let dir = String(parts[0]), amount = Int(parts[1])!
        if !reduced.isEmpty && canReduce(reduced.last!.0, dir) {
            if reduced.last!.0 == dir {
                reduced[reduced.count-1] = (dir, reduced.last!.1 + amount)
            } else {
                if reduced.last!.1 == amount {
                    reduced.removeLast()
                } else if reduced.last!.1 > amount {
                    reduced[reduced.count-1].1 = reduced.last!.1 - amount
                } else {
                    reduced[reduced.count-1] = (dir, amount - reduced.last!.1)
                }
            }
        } else {
            reduced.append((dir, amount))
        }
    }

    let result = reduced.map({ "\($0.0) \($0.1)" }).joined(separator: "\n")
    print(result)
    try? result.write(toFile: "output.txt", atomically: true, encoding: .utf8)
}

readNums()
