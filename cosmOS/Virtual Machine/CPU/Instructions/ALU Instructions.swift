//
//  Instructions.swift
//  cosmOS
//
//  Created by Danial Haseeb on 05/11/2022.
//

extension Core
{
  static func MOV()
  {
    guard
      let one: Byte = MMU.next(),
      let two: Byte = MMU.next()
    else
    { return }
    guard
      let _ = R[one],
      let R2 = R[two]
    else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.move(R2, to: &R[one]!)
  }
  
  static func ADD()
  {
    guard
      let one: Byte = MMU.next(),
      let two: Byte = MMU.next()
    else
    { return }
    guard
      let _ = R[one],
      let R2 = R[two]
    else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.add(R2, to: &R[one]!)
  }
  
  static func SUB()
  {
    guard
      let one: Byte = MMU.next(),
      let two: Byte = MMU.next()
    else
    { return }
    guard
      let _ = R[one],
      let R2 = R[two]
    else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.subtract(R2, from: &R[one]!)
  }
  
  static func MUL()
  {
    guard
      let one: Byte = MMU.next(),
      let two: Byte = MMU.next()
    else
    { return }
    guard
      let _ = R[one],
      let R2 = R[two]
    else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.multiply(&R[one]!, by: R2)
  }
  
  static func DIV()
  {
    guard
      let one: Byte = MMU.next(),
      let two: Byte = MMU.next()
    else
    { return }
    guard
      let _ = R[one],
      let R2 = R[two]
    else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.divide(&R[one]!, by: R2)
  }
  
  static func AND()
  {
    guard
      let one: Byte = MMU.next(),
      let two: Byte = MMU.next()
    else
    { return }
    guard
      let _ = R[one],
      let R2 = R[two]
    else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.and(&R[one]!, with: R2)
  }
  
  static func OR()
  {
    guard
      let one: Byte = MMU.next(),
      let two: Byte = MMU.next()
    else
    { return }
    guard
      let _ = R[one],
      let R2 = R[two]
    else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.or(&R[one]!, with: R2)
  }
  
  static func MOVI()
  {
    guard
      let one: Byte = MMU.next(),
      let imm: Word = MMU.next()
    else
    { return }
    guard let _ = R[one] else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.move(imm, to: &R[one]!)
  }
  
  static func ADDI()
  {
    guard
      let one: Byte = MMU.next(),
      let imm: Word = MMU.next()
    else
    { return }
    guard let _ = R[one] else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.add(imm, to: &R[one]!)
  }
  
  static func SUBI()
  {
    guard
      let one: Byte = MMU.next(),
      let imm: Word = MMU.next()
    else
    { return }
    guard let _ = R[one] else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.subtract(imm, from: &R[one]!)
  }
  
  static func MULI()
  {
    guard
      let one: Byte = MMU.next(),
      let imm: Word = MMU.next()
    else
    { return }
    guard let _ = R[one] else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.multiply(&R[one]!, by: imm)
  }
  
  static func DIVI()
  {
    guard
      let one: Byte = MMU.next(),
      let imm: Word = MMU.next()
    else
    { return }
    guard let _ = R[one] else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.divide(&R[one]!, by: imm)
  }
  
  static func ANDI()
  {
    guard
      let one: Byte = MMU.next(),
      let imm: Word = MMU.next()
    else
    { return }
    guard let _ = R[one] else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.and(&R[one]!, with: imm)
  }
  
  static func ORI()
  {
    guard
      let one: Byte = MMU.next(),
      let imm: Word = MMU.next()
    else
    { return }
    guard let _ = R[one] else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.or(&R[one]!, with: imm)
  }
  
  static func SHL()
  {
    guard let one: Byte = MMU.next() else
    { return }
    guard let _ = R[one] else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.shift(.left, on: &R[one]!, by: 1)
  }
  
  static func SHR()
  {
    guard let one: Byte = MMU.next() else
    { return }
    guard let _ = R[one] else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.shift(.right, on: &R[one]!, by: 1)
  }
  
  static func RTL()
  {
    guard let one: Byte = MMU.next() else
    { return }
    guard let _ = R[one] else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.rotate(.left, &R[one]!)
  }
  
  static func RTR()
  {
    guard let one: Byte = MMU.next() else
    { return }
    guard let _ = R[one] else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.rotate(.right, &R[one]!)
  }
  
  static func INC()
  {
    guard let one: Byte = MMU.next() else
    { return }
    guard let _ = R[one] else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.add(1, to: &R[one]!)
  }
  
  static func DEC()
  {
    guard let one: Byte = MMU.next() else
    { return }
    guard let _ = R[one] else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    ALU.subtract(1, from: &R[one]!)
  }
}
