//
//  CU Interrupts.swift
//  cosmOS
//
//  Created by Danial Haseeb on 05/11/2022.
//

extension CU
{
  enum Interrupt: Handleable
  {
    case codeLimit
    
    var message: String
    {
      switch self
      {
        case .codeLimit:
          return "CU: Given code address > code limit."
      }
    }
  }
}
