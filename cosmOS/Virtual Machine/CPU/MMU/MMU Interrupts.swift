//
//  Interrupts.swift
//  cosmOS
//
//  Created by Danial Haseeb on 03/11/2022.
//

extension MMU
{
  /// The set of interrupts that can occur during main memory access.
  enum Interrupt
  {
    /// This interrupt is raised when the MMU cannot find a given page in its page table.
    case pageNotInTable
    
    /// This interrupt is raised when a process attempts to access data out of bounds.
    case dataLimit
    
    /// This interrupt is raised when a process attempts to push a byte onto a stack that is already full.
    case stackOverflow
    
    /// This interrupt is raised when a process attempts to pop a byte from  a stack that is empty.
    case stackUnderflow
  }
}
