//
//  ALU Interrupts.swift
//  cosmOS
//
//  Created by Danial Haseeb on 05/11/2022.
//

extension ALU
{
  enum Interrupt: Handleable
  {
    case singularity
    
    var message: String
    {
      switch self
      {
        case .singularity:
          return "ALU: Cannot divide by 0." 
      }
    }
  }
}
