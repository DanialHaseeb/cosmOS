//
//  Interrupts.swift
//  cosmOS
//
//  Created by Danial Haseeb on 03/11/2022.
//

extension MMU
{
  /// The set of interrupts that can occur during main memory access.
  enum Interrupt: Handleable
  {
    /// This interrupt is raised when the MMU cannot find a given page in its page table.
    case pageNotInTable
    
    /// This interrupt is raised when a process attempts to access data out of bounds.
    case dataLimit
    
    /// This interrupt is raised when a process attempts to access code out of bounds.
    case codeLimit
    
    /// This interrupt is raised when a process attempts to push a byte onto a stack that is already full.
    case stackOverflow
    
    /// This interrupt is raised when a process attempts to pop a byte from  a stack that is empty.
    case stackUnderflow
    
    var message: String
    {
      switch self
      {
        case .pageNotInTable:
          return "MMU: Given page ∉ page table."
        case .dataLimit:
          return "MMU: Given data address > data limit."
        case .codeLimit:
          return "MMU: Given code address > code limit."
        case .stackOverflow:
          return "MMU: Stack overflow."
        case .stackUnderflow:
          return "MMU: Stack underflow."
      }
    }
  }
}
