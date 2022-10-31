//
//  MMU.swift
//  cosmOS
//
//  Created by Danial Haseeb on 30/10/2022.
//

/// The virtual machine's memory management unit.
class MMU
{
  // MARK: Alias
  typealias PageTable = [Int: Int]
  
  // MARK: Interrupts
  
  enum Interrupt: Exception
  { case pageNotInTable }
  
  // MARK: Stored Properties
  
  /// The page table of the current process.
  static var pageTable: PageTable = [:]
  
  /// Store the given byte at the given address in main memory.
  ///
  /// This function is only meant to be used by **cosmOS**
  /// since it does not enfore any memory protections.
  ///
  /// - Parameters:
  ///   - byte: The byte to be stored in main memory.
  ///   - address: The main memory address at which the byte will be stored.
  static func store(_ byte: Byte, at address: Word)
  {
    let address = Address(address)          // store address
    let page = MMU.pageTable[address.page]  // store page
    let offset = address.offset             // store offset
    
    if let page
    { Memory.contents[page][offset] = byte }
    else
    { Kernel.raise(Interrupt.pageNotInTable) }
  }
}
