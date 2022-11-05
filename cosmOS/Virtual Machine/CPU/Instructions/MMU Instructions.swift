//
//  MMU Instructions.swift
//  cosmOS
//
//  Created by Danial Haseeb on 05/11/2022.
//

extension Core
{
  static func MOVL()
  {
    guard
      let one: Byte = MMU.next(),
      let imm: Word = MMU.next(),
      let word: Word = MMU.load(from: imm)
    else
    { return }
    guard let _ = R[one] else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    R[one]! = word
  }
  
  static func MOVS()
  {
    guard
      let one: Byte = MMU.next(),
      let imm: Word = MMU.next()
    else
    { return }
    guard let word = R[one] else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    MMU.store(word, at: imm)
  }
  
  static func PUSH()
  {
    guard let one: Byte = MMU.next() else
    { return }
    guard let R1 = R[one] else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    MMU.push(R1)
  }
  
  static func POP()
  {
    guard
      let one: Byte = MMU.next(),
      let word: Word = MMU.pop()
    else
    { return }
    guard let _ = R[one] else
    {
      Kernel.raise(Interrupt.invalidRegister)
      return
    }
    R[one]! = word
  }
}
