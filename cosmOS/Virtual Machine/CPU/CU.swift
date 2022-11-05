//
//  CU.swift
//  cosmOS
//
//  Created by Danial Haseeb on 05/11/2022.
//

/// The virtual machine's control unit.
class CU
{
  /// Jumps to the instruction at the given address if the given condition is true.
  ///
  /// - Parameters:
  ///   - address: The given address to which the programme counter will point.
  ///   - condition: The given branching condition.
  ///
  /// - Requires: `code base` + `address` ≤ `code limit`
  static func branch(to address: Word, if condition: Bool = true)
  {
    func jump(to address: Word)
    {
      let base = Core.S[1]
      let limit = Core.S[2]
      let counter = base + address
      guard (counter <= limit) else
      {
        Kernel.raise(Interrupt.codeLimit)
        return
      }
      Core.S[3] = counter
    }
    
    if condition
    { jump(to: address) }
  }
}
