//
//  main.swift
//  cosmOS
//
//  Created by Danial Haseeb on 29/10/2022.
//

import Foundation

/// Reads a (valid) pathname from the standard input stream.
func inputPath() -> String
{
  /* Read user input. */
  print("Enter path to programme files directory:")
  var path = readLine()!
  
  /// Checks whether the input `path` is a valid pathname for cosmOS.
  /// It should point to the directory containing programme files.
  func pathIsValid() -> Bool
  {
    /* Initialise variables. */
    let fileManager = FileManager.default
    var isDirectory: ObjCBool = false
    
    /* Check validity. */
    let pathExists = fileManager.fileExists(atPath: path,
                                            isDirectory: &isDirectory)
    let pathIsDirectory = isDirectory.boolValue
    
    /* Output. */
    return pathExists && pathIsDirectory
  }
  
  while !pathIsValid()              // while path is invalid:
  {
    print("Invalid path. Try again:") // display error prompt
    path = readLine()!                // read new user input
    print()                           // insert line break
  }
  
  print()     // line break
  return path // return valid input path
}

Bootstrap()
Disk(at: inputPath())
Kernel()

while
  (
    !Kernel.queue1.isEmpty
    ||
    !Kernel.queue2.isEmpty
    ||
    Kernel.currentProcess.state != .terminated
  )
{ Clock.tick() }

for process in Kernel.processes
{
  let ᴜʀʟ = URL(fileURLWithPath: "./\(process.name).md", isDirectory: false)
  try! "\(process)".write(to: ᴜʀʟ, atomically: false, encoding: .utf8)
}

let ᴜʀʟ = URL(fileURLWithPath: "./Memory.md", isDirectory: false)
try! "\(Memory())".write(to: ᴜʀʟ, atomically: false, encoding: .utf8)

let godSpeed =
"""
.
.
.
Maximum entropy has been reached...
Head death fast approaches...
The concept of time itself evaporates...
And the cosmOS ceases to exist.
.
.
.
Godspeed. 💫
"""

print(godSpeed)
