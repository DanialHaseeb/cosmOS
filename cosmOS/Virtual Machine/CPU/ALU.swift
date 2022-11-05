//
//  ALU.swift
//  cosmOS
//
//  Created by Danial Haseeb on 05/11/2022.
//

/// The virtual machine's arithmetic and logic unit.
class ALU
{
  /// The sets of all functions that can be performed by the virtual machine's ALU.
  enum Operation
  {
    /// The set of all arithmetic operations that can be performed by the virtual machine's ALU.
    enum Arithmetic
    { case add, subtract, multiply, divide }

    /// The set of all logical operations that can be performed by the virtual machine's ALU.
    enum Logical
    { case and, or }
    
    /// The possible directions for the logical bit-shift and rotate operations.
    enum Direction
    { case left, right }
  }
  
  static func arithmetic(_ operation: Operation.Arithmetic,
                         between R: inout Register,
                         and value: Word)
  {
    /* Make signed operands for arithmetic. */
    let zero = Core.S[0]
    let operand1 = R.signed
    let operand2 = value.signed
    
    /* Do the arithmetic. */
    var (result, overflow) = (Int16(), Bool())
    switch operation
    {
      case .add:
        (result, overflow) = operand1.addingReportingOverflow(operand2)
      case .subtract:
        (result, overflow) = operand1.subtractingReportingOverflow(operand2)
      case .multiply:
        (result, overflow) = operand1.multipliedReportingOverflow(by: operand2)
      case .divide:
        guard (operand2 != zero) else
        {
          Kernel.raise(Interrupt.singularity)
          return
        }
        (result, overflow) = operand1.dividedReportingOverflow(by: operand2)
    }
    
    /* Update registers. */
    R = Register(bitPattern: result)  // R <- result
    Core.S[9].bits[1] = (R == zero)   // update zero flag
    Core.S[9].bits[2] = R.bits.last!  // update sign flag
    Core.S[9].bits[3] = overflow      // update overflow flag
  }
  
  static func logical(_ operation: Operation.Logical,
                      between R: inout Register,
                      and value: Word)
  {
    let zero = Core.S[0]
    switch operation
    {
      case .and:
        R &= value
      case .or:
        R |= value
    }
    Core.S[9].bits[1] = (R == zero)   // update zero flag
    Core.S[9].bits[2] = R.bits.last!  // update sign flag
  }
  
  /// Moves the given value into a register.
  ///
  /// - Parameters:
  ///   - value: The value to be moved.
  ///   - R: The register to which the value will be moved.
  ///
  static func move(_ value: Register, to R: inout Register)
  { R = value } // R1 <- R2
  
  /// Adds a given a value to a register.
  ///
  /// - Parameters:
  ///   - value: The given value.
  ///   - R: The register to which the value is added.
  ///
  /// - Note: All arithmetic is signed.
  static func add(_ value: Word, to R: inout Register)
  { arithmetic(.add, between: &R, and: value) }
  
  /// Subtracts a given a value from a register.
  ///
  /// - Parameters:
  ///   - value: The given value.
  ///   - R: The register from which the value is subtracted.
  ///
  /// - Note: All arithmetic is signed.
  static func subtract(_ value: Word, from R: inout Register)
  { arithmetic(.subtract, between: &R, and: value) }
  
  /// Multiplies a register by the given value.
  ///
  /// - Parameters:
  ///   - R: The register to be multiplied
  ///   - value: The value by which to multiply.
  ///
  /// - Note: All arithmetic is signed.
  static func multiply(_ R: inout Register, by value: Word)
  { arithmetic(.multiply, between: &R, and: value) }
  
  /// Divides a register by the given value.
  ///
  /// - Parameters:
  ///   - R: The register to be divided
  ///   - value: The value by which to divide.
  ///
  /// - Note: All arithmetic is signed.
  static func divide(_ R: inout Register, by value: Word)
  { arithmetic(.divide, between: &R, and: value) }
  
  /// Performs a logical _and_ operation on a register with a given value.
  ///
  /// - Parameters:
  ///   - R: The register on which the logical _and_ will be performed.
  ///   - value: The value with which the logical _and_ will be performed..
  static func and(_ R: inout Register, with value: Word)
  { logical(.and, between: &R, and: value) }
  
  /// Performs a logical _or_ operation on a register with a given value.
  ///
  /// - Parameters:
  ///   - R: The register on which the logical _or_ will be performed.
  ///   - value: The value with which the logical _or_ will be performed..
  static func or(_ R: inout Register, with value: Word)
  { logical(.or, between: &R, and: value) }
  
  /// Performs a logical bit-shift operation in the given direction on a register by a given amount.
  ///
  /// - Parameters:
  ///   - direction: The direction in which to shift bits.
  ///   - R: The register whose bits are to be shifted.
  ///   - amount: The amount by which the bits will be shifted.
  static func shift(_ direction: Operation.Direction,
                    on R: inout Register,
                    by amount: Int)
  {
    let zero = Core.S[0]
    Core.S[9].bits[0] = R.bits.last!  // update carry flag
    switch direction
    {
      case .left:
        R <<= amount                  // R <- R << amount
      case .right:
        R >>= amount                  // R <- R >> amount
    }
    Core.S[9].bits[1] = (R == zero)   // update zero flag
    Core.S[9].bits[2] = R.bits.last!  // update sign flag
  }
  
  /// Performs a logical rotate operation in the given direction on a register.
  ///
  /// - Parameters:
  ///   - direction: The direction in which to rotate bits.
  ///   - R: The register whose bits are to be rotated.
  static func rotate(_ direction: Operation.Direction, _ R: inout Register)
  {
    let zero = Core.S[0]
    var bit = Bool()
    switch direction
    {
      case .left:
        bit = R.bits.last!  // store last bit
        R <<= 1             // bitshift left by 1
        R.bits[0] = bit     // new first bit <- old last bit
      case .right:
        bit = R.bits.first! // store first bit
        R >>= 1             // bitshift right by 1
        R.bits[15] = bit    // new last bit <- old first bit
    }
    Core.S[9].bits[1] = (R == zero)  // update zero flag
    Core.S[9].bits[2] = R.bits.last!  // update sign flag
  }
}
