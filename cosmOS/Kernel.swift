//
//  Kernel.swift
//  cosmOS
//
//  Created by Danial Haseeb on 30/10/2022.
//

/// The virtual machine's operating system.
class Kernel
{
  // MARK: Class Variables
  
  /// The set of process IDs currently in use.
  ///
  /// It is used to ensure all process IDs are unique.
  static var IDs: Set<Process.ID> = []
  
  /// The set of pages not currently in use by any process.
  ///
  /// It is used to ensure only free pages of memory are allocated to new processes.
  static var pages = Set(0..<Memory.size)
  
  /// The list of all processes ever instantiated by **cosmOS**.
  static var processes: [Process] = []
  
  // MARK: Class Functions
  
  /// The universal interrupt handler.
  ///
  /// TO DO: Implementation
  static func raise(_ interrupt: any Exception)
  { }
  
  /// Allocates free pages from main memory for a given size of data.
  ///
  /// - Parameter size: The size of data (in bytes).
  ///
  /// - Returns: A page table mapping the virtual pages to the allocated physical pages.
  static func allocate(_ size: Int) -> MMU.PageTable?
  {
    /// Quick and dirty function to calculate the number of pages in main memory taken by this process.
    func pagesRequired(for size: Int) -> Int
    {
      let atLeast = size / Memory.Page.size
      let maybeOneMore = (size % Memory.Page.size == 0) ? 0 : 1
      return atLeast + maybeOneMore
    }
    
    var pageTable: MMU.PageTable = [:]          // initialise page table
    let pages = pagesRequired(for: size)        // calculate pages required
    for i in (0..<pages)                        // loop through pages required:
    {
      guard !(Kernel.pages.isEmpty) else        //   if no free pages:
      { return nil }                            //     return nothing
      pageTable[i] = Kernel.pages.removeFirst() //   add page table entry
    }
    return pageTable
  }
}
