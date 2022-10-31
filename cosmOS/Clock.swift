//
//  Clock.swift
//  cosmOS
//
//  Created by Danial Haseeb on 30/10/2022.
//

/// The virtual machine's system clock.
class Clock
{
  // MARK: Alias
  
  /// The system time.
  ///
  /// Measured as a monotonically non-decreasing integer that increments by 1 each clock cycle.
  typealias Time = Int
  
  // MARK: Stored Property
  
  /// The current time on the system clock.
  static var time = Time(0)
  
  // MARK: Class Function
  
  /// Time step over to the next system clock cycle.
  static func tick()
  {
    for process in Kernel.processes
    {
      switch process.state
      {
        case .ready:
          process.time.waiting += 1
        case .fetching:
          process.time.execution += 1
        case .executing:
          process.time.execution += 1
        default:
          break
      }
    }
    
    Clock.time += 1
  }
}
