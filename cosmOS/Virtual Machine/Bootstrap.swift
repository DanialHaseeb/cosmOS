//
//  Bootstrap.swift
//  cosmOS
//
//  Created by Danial Haseeb on 04/11/2022.
//

import Foundation

class Bootstrap
{
  /// The programme responsible for booting **cosmOS**.
  func boot()
  {
    func loadingAnimation(repeating time: Int)
    {
      for _ in (1...time)
      {
        print("⏳", terminator: "")
        sleep(1)
        print("⌛️", terminator: "")
        sleep(1)
      }
    }

    print("💥")
    print()
    print("Please wait while the virtual machine starts...")
    loadingAnimation(repeating: 3)
    print()
    
    Core.load(Kernel.task)
    print(Kernel.logo)
  }
  
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
  
  @discardableResult
  init()
  {
    boot()
    Disk(at: inputPath())
  }
}


