//
//  Process Interrupts.swift
//  cosmOS
//
//  Created by Danial Haseeb on 04/11/2022.
//

extension Process
{
  /// The set of interrupts that may be raised during process creation.
  enum Interrupt: Handleable
  {
    /// The interrupt raised when the process ID is already in use by **cosmOS**.
    case invalidID
    
    /// The interrupt raised when there are no free pages remaining in main memory to load this process.
    case noFreeFrames
    
    var message: String
    {
      switch self
      {
        case .invalidID:
          return "Process ID already in use."
        case .noFreeFrames:
          return "Memory full."
      }
    }
    
    func handle()
    { print("❌ Error: \(message) ---", terminator: " ") }
  }
}
