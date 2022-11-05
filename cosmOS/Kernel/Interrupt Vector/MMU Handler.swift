//
//  MMU Handler.swift
//  cosmOS
//
//  Created by Danial Haseeb on 04/11/2022.
//

extension MMU.Interrupt: Handleable
{
  var message: String
  {
    switch self
    {
      case .pageNotInTable:
        return "MMU couldn't find page in page table."
      case .dataLimit:
        return "Given data address exceeds data limit."
      case .stackOverflow:
        return "Stack overflow."
      case .stackUnderflow:
        return "Stack underflow."
    }
  }
}
