//
//  MMU.swift
//  cosmOS
//
//  Created by Danial Haseeb on 30/10/2022.
//

/// The virtual machine's memory management unit.
class MMU
{
  /// Stores the given byte at the given address in a data segment of main memory.
  ///
  /// - Parameters:
  ///   - byte: The byte to be stored in main memory.
  ///   - address: The logical address at which the byte will be stored.
  ///
  /// - Requires: `data base` + `address` ≤ `data limit`
  static func store(_ byte: Byte, at address: Word)
  {
    let base = Core.S[7],                 // data base
        limit = Core.S[8]                 // data limit
    
    let virtual = base + address          // virtual <- data base + address
    
    guard (virtual <= limit) else         // if virtual > data limit:
    {
      Kernel.raise(Interrupt.dataLimit)   //   raise interrupt
      return
    }

    let address = Address(virtual)        // convert word to address
    
    let frame  = pageTable[address.page]  // store frame
    let offset = address.offset           // store offset
    
    Memory.contents[frame][offset] = byte // store byte in memory
  }
  
  /// Stores the given word at the given address in a data segment of main memory..
  ///
  /// - Parameters:
  ///   - word: The word to be stored in main memory.
  ///   - address: The logical address at which the byte will be stored.
  ///
  /// - Requires: `data base` + `address` ≤ `data limit`
  static func store(_ word: Word, at address: Word)
  {
    store(word.bytes.last!, at: address)
    store(word.bytes.first!, at: address + 1)
  }
  
  /// Loads the byte stored at the given address in a data segment of main memory..
  ///
  /// - Parameter address: The logical address at which the byte is stored.
  ///
  /// - Returns: The byte stored at the given address.
  ///
  /// - Requires: `data base` + `address` ≤ `data limit`
  static func load(from address: Word) -> Byte?
  {
    let base = Core.S[7],                 // data base
        limit = Core.S[8]                 // data limit
      
    let virtual = base + address          // virtual <- data base + address
      
    guard (virtual <= limit) else         // if virtual > data limit:
    {
      Kernel.raise(Interrupt.dataLimit)   //   raise interrupt
      return nil
    }

    let address = Address(virtual)        // convert word to address
    
    let frame  = pageTable[address.page]  // store frame
    let offset = address.offset           // store offset
    
    return Memory.contents[frame][offset] // return byte
  }
  
  /// Loads the word stored at the given address in a data segment of main memory..
  ///
  /// - Parameter address: The logical address at which the byte is stored.
  ///
  /// - Returns: The word stored at the given address.
  ///
  /// - Requires: `data base` + `address` ≤ `data limit`
  static func load(from address: Word) -> Word?
  {
    guard let ms: Byte = load(from: address) else
    { return nil }
    guard let ls: Byte = load(from: address + 1) else
    { return nil }
    return Word(ms, ls)
  }
  
  /// Pushes the given byte onto a stack segment in main memory.
  ///
  /// - Parameter byte: The given byte to be pushed.
  ///
  /// - Requires: The stack must have enough free space.
  static func push(_ byte: Byte)
  {
    let bound   = Core.S[5] - 1,            // stack bound <- stack limit - 1
        counter = Core.S[6],                // stack counter
        newCounter = counter - 1            // new stack counter
    
    guard (newCounter >= bound) else        // if stack overflow:
    {
      Kernel.raise(Interrupt.stackOverflow) //   raise interrupt
      return
    }
    
    let address = Address(counter)          // convert word to address
    
    let frame  = pageTable[address.page]    // store frame
    let offset = address.offset             // store offset
    
    Core.S[6] = newCounter                  // store new stack counter
    Memory.contents[frame][offset] = byte   // store byte in memory
  }
  
  /// Pushes the given word onto a stack segment in main memory.
  ///
  /// - Parameter word: The given byte to be pushed.
  ///
  /// - Requires: The stack must have enough free space.
  static func push(_ word: Word)
  {
    push(word.bytes.first!) // push first byte of word
    push(word.bytes.last!)  // push last byte of word
  }
  
  /// Pops a byte from  a stack segment in main memory.
  ///
  /// - Returns: The byte at the top of the stack.
  ///
  /// - Requires: The stack must not be empty.
  static func pop() -> Byte?
  {
    let counter = Core.S[6] - 1,              // new stack counter
        base    = Core.S[4]                   // stack base
    
    guard (counter >= base) else              // if stack underflow:
    {
      Kernel.raise(Interrupt.stackUnderflow)  //   raise interrupt
      return nil
    }
    
    let address = Address(counter)            // convert word to address
    
    let frame  = pageTable[address.page]      // store frame
    let offset = address.offset               // store offset
      
    Core.S[6] = counter                       // store new stack counter
    return Memory.contents[frame][offset]     // store byte in memory
  }
  
  /// Pops a word from  a stack segment in main memory.
  ///
  /// - Returns: The word at the top of the stack.
  ///
  /// - Requires: The stack must not be empty.
  static func pop() -> Word?
  {
    guard let ms: Byte = pop() else
    { return nil }
    guard let ls: Byte = pop() else
    { return nil }
    return Word(ms, ls)
  }
  
  // TODO: static func nextInstruction() { }
}
