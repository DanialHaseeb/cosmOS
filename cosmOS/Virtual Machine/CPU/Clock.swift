//
//  Clock.swift
//  cosmOS
//
//  Created by Danial Haseeb on 30/10/2022.
//

/// The virtual machine's system clock.
class Clock
{
  /// The current time on the system clock.
  static var time = Time(0)
  
  /// Time step over to the next system clock cycle.
  static func tick()
  {
    Kernel.dispatch()
    
    Core.run()
    
    for process in Kernel.readyProcesses
    { process.time.waiting += 1 }
    
    Kernel.currentProcess.time.execution += 1
    
    Kernel.detectInfiniteLoop()
    
    Clock.time += 1 // increment the system time by 1
  }
}
