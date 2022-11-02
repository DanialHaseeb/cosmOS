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
    for process in Kernel.processes   // loop through every process:
    {
      switch process.state            //   when the process state is:
      {
        case .ready:                  //     ready:
          process.time.waiting += 1   //       increment waiting time by 1
        case .fetching, .executing:   //     running:
          process.time.execution += 1 //       increment execution time by 1
        default:                      //     other:
          break                       //       do nothing
      }
    }
    
    Clock.time += 1 // increment the system time by 1
  }
}
