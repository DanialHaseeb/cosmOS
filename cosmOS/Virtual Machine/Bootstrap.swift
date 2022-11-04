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
    
  }
  

  
  @discardableResult
  init()
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
    loadingAnimation(repeating: 1)
    print()
    
    Core.load(Kernel.task)
    print(Kernel.logo)
  }
}


