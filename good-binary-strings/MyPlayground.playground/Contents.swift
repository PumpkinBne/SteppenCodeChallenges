import UIKit

var greeting = "Hello, playground"

func largestGood(from original: String) -> String {
    // assume `original` is a good string
    
    var pin = 0
    var finalisedIndex = -1
    var nextSubstring = ""
    var partitioned: [String] = []
    let originalStringArray = Array(original)
    for (index, item) in originalStringArray.enumerated() {
        
        let nextTarget: String.Element? = originalStringArray.indices.contains(index + 1) ? originalStringArray[index + 1] : nil
        
        // move pin
        if item == "0" { pin += 1 }
        else { pin -= 1 }
        
        nextSubstring += String(item)
        
        if nextTarget == nil {
            partitioned.append(nextSubstring)
            break;
        }
        
        // if pin is 0, then current substring is a good string
        if pin == 0 {
            partitioned.append(nextSubstring)
            nextSubstring = ""
            finalisedIndex = index
        } else {
            // if target is 0 and nextTarget is 1, might have missed sub good
            if item == "0" && nextTarget == "1" {
                let currentToStartBackwards = Array(originalStringArray[finalisedIndex + 1...index]).reversed()
                var backwardsPin = 0;
                var backwardSubString: [String] = []
                for (index2, item2) in currentToStartBackwards.enumerated() {
                    if item2 == "0" { backwardsPin += 1 }
                    else { backwardsPin -= 1 }
                    backwardSubString.insert(String(item2), at: 0)
                    
                    if index2 == currentToStartBackwards.count - 1 {
                        partitioned.append(nextSubstring)
                        nextSubstring = ""
                        pin = 0
                        finalisedIndex = index
                        break
                    }
                    
                    if backwardsPin == 0 {
                        var nonGoodString = ""
                        let remaining = currentToStartBackwards.suffix(currentToStartBackwards.count - index2 - 1)
                        remaining.reversed().forEach { c in nonGoodString += String(c)}
                        let missedGoodSubString = backwardSubString.joined()
                        
                        partitioned.append(nonGoodString)
                        partitioned.append(missedGoodSubString)
                        finalisedIndex = index
                        pin = 0
                        nextSubstring = ""
                        break
                    }
                }
            }
        }
    }
    
    // no good substrings
    if partitioned.count == 1 { return partitioned[0]}
   
    var fixedPos: [Int] = []
    for (i, p) in partitioned.enumerated() {
        if p.count == 1 {
            fixedPos.append(i)
        }
    }
    
    // everything can be swapped
    if fixedPos.count == 0 {
        let sorted = partitioned.sorted()
        var reversed = Array(sorted.reversed())
        return reversed.joined()
    }
    
    // consecutive swap
    var partitionedForSwap: [String] = []
    var lastIndex = 0

    for pos in fixedPos {
        if pos == 0 {
            partitionedForSwap.append(partitioned[pos])
        } else {
            let subArray = partitioned[(lastIndex + 1)..<pos]
            let sorted = subArray.sorted()
            let reversed = Array(sorted.reversed())
            partitionedForSwap.append(reversed.joined() + partitioned[pos])
            lastIndex = pos
        }
       
    }
    
    if fixedPos.last != partitioned.count - 1 {
        let subArray = partitioned[(fixedPos.last! + 1)..<partitioned.count]
        let sorted = subArray.sorted()
        let reversed = Array(sorted.reversed())
        partitionedForSwap.append(reversed.joined())
    }
    
    return partitionedForSwap.joined()

}

print(largestGood(from: "11011000")) // -> 11100100 :: 1-10-1100-0 ->
print(largestGood(from: "1100"))
print(largestGood(from: "1101001100")) // 1-10-10-0-1100

