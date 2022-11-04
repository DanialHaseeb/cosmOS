//
//  PageTable.swift
//  cosmOS
//
//  Created by Danial Haseeb on 02/11/2022.
//

/// The virtual representation of page tables in the architecture.
typealias PageTable = [Int]

extension MMU
{
  /// The page table of the current process.
  static var pageTable: PageTable = []
}
