//
//  Memory.swift
//  cosmOS
//
//  Created by Danial Haseeb on 29/10/2022.
//

/// The main (dynamic and random-access) memory.
class Memory
{
  /// The number of pages in the main memory.
  ///
  /// This property is determined by the address space and page size,
  /// both of which are defined by the virtual machine architecture.
  static let size = Address.space / Memory.Frame.size
  
  /// The main memory contents.
  static var contents = Array(repeating: Frame(), count: Memory.size)
}
