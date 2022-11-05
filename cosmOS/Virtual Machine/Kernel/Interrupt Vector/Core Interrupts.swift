//
//  Core Interrupts.swift
//  cosmOS
//
//  Created by Danial Haseeb on 05/11/2022.
//

extension Core
{
  enum Interrupt: Handleable
  {
    case invalidOpcode
    case invalidRegister
    
    var message: String
    {
      switch self
      {
        case .invalidOpcode:
          return "Core: Source code has invalid operation code."
        case .invalidRegister:
          return "Core: Source code has invalid register code."
      }
    }
  }
}
