//
//  CU Instructions.swift
//  cosmOS
//
//  Created by Danial Haseeb on 05/11/2022.
//

extension Core
{
  static func BZ()
  {
    guard let imm: Word = MMU.next() else
    { return }
    let zero = S[9].bits[1]
    CU.branch(to: imm, if: zero)
  }
  
  static func BNZ()
  {
    guard let imm: Word = MMU.next() else
    { return }
    let zero = S[9].bits[1]
    CU.branch(to: imm, if: !zero)
  }
  
  static func BC()
  {
    guard let imm: Word = MMU.next() else
    { return }
    let carry = S[9].bits[0]
    CU.branch(to: imm, if: carry)
  }
  
  static func BS()
  {
    guard let imm: Word = MMU.next() else
    { return }
    let sign = S[9].bits[2]
    CU.branch(to: imm, if: sign)
  }
  
  static func JMP()
  {
    guard let imm: Word = MMU.next() else
    { return }
    CU.branch(to: imm)
  }
  
  static func CALL()
  {
    guard let imm: Word = MMU.next() else
    { return }
    let pc = S[3]
    MMU.push(pc)
    CU.branch(to: imm)
  }
  
  static func ACT()
  {
    guard let _: Word = MMU.next() else
    { return }
  }
  
  static func RETURN()
  {
    guard let pc: Register = MMU.pop() else
    { return }
    S[3] = pc
  }
  
  static func NOOP()
  { }
  
  static func END()
  { state = .terminated }
}
