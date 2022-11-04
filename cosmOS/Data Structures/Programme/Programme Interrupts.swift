//
//  Programme Interrupts.swift
//  cosmOS
//
//  Created by Danial Haseeb on 04/11/2022.
//

extension Programme
{
  /// The set of interrupts that may be raised during programme creation.
  enum Interrupt
  {
    /// |`programme`| < 8
    case invalidSize
    
    /// `priority` ∉ [0, 31]
    case invalidPriority
    
    /// |`data`| > |`programme`|
    case invalidDataSize
  }
}
