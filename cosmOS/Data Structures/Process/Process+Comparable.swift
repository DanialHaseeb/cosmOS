//
//  Process+Comparable.swift
//  cosmOS
//
//  Created by Danial Haseeb on 04/11/2022.
//

extension Process: Comparable
{
  static func < (lhs: Process, rhs: Process) -> Bool
  { lhs.ID > rhs.ID }
  
  static func == (lhs: Process, rhs: Process) -> Bool
  { lhs.ID == rhs.ID }
}
