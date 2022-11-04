//
//  Programme Handler.swift
//  cosmOS
//
//  Created by Danial Haseeb on 04/11/2022.
//

extension Programme.Interrupt: Handleable
{
  var message: String
  {
    switch self
    {
      case .invalidSize:
        return "|programme| < 8"
      case .invalidPriority:
        return "priority ∉ [0, 31]"
      case .invalidDataSize:
        return "|data| > |programme|"
    }
  }
  
  func handle()
  { print("❌ Error: \(message) ---", terminator: " ") }
}
