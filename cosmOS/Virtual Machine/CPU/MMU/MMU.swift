//
//  MMU.swift
//  cosmOS
//
//  Created by Danial Haseeb on 30/10/2022.
//

/// The virtual machine's memory management unit.
class MMU
{
  /// Stores the given byte at the given address in main memory.
  ///
  /// - Parameters:
  ///   - byte: The byte to be stored in main memory.
  ///   - address: The main memory address at which the byte will be stored.
  static func store(_ byte: Byte, at address: Word)
  {
    let address = Address(address)        // convert word to address
    
    let frame  = pageTable[address.page]  // store frame
    let offset = address.offset           // store offset
    
    Memory.contents[frame][offset] = byte // store byte in memory
  }
}
