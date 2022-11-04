//
//  Allocator.swift
//  cosmOS
//
//  Created by Danial Haseeb on 04/11/2022.
//

extension Kernel
{
  /// The set of frames not currently in use by any process.
  ///
  /// It is used to ensure only free frames of memory are allocated to new processes.
  static var frameTable = Set(0..<Memory.size)
  
  /// Allocates free pages from main memory for a given size of data.
  ///
  /// - Parameter size: The size of data (in bytes).
  ///
  /// - Returns: A page table mapping the pages to the allocated frames.
  static func allocate(_ size: Int) -> PageTable?
  {
    /// Calculates the number of pages in main memory taken by the given process.
    func pagesRequired(for size: Int) -> Int
    {
      let atLeast = size / Memory.Frame.size
      let maybeOneMore = (size % Memory.Frame.size == 0) ? 0 : 1
      return atLeast + maybeOneMore
    }
    
    var pageTable: PageTable = []             // initialise page table
    let pages = pagesRequired(for: size)      // calculate pages required
    for i in (0..<pages)                      // loop through pages required:
    {
      guard !(Kernel.frameTable.isEmpty) else //   if no free pages:
      { return nil }                          //     return nothing
      
      /* Add page table entry. */
      pageTable[i] = Kernel.frameTable.removeFirst()
    }
    return pageTable
  }
}
