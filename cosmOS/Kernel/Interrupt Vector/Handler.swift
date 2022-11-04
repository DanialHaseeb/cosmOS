//
//  Handler.swift
//  cosmOS
//
//  Created by Danial Haseeb on 30/10/2022.
//

/// All interrupts handleable by **cosmOS** adopt this protocol.
protocol Handleable
{ var message: String { get } }

extension Handleable
{
  func handle()
  {
    let log =
    """
    ------------------------------------------
    ⚠️ Interrupt at time: \(Clock.time)
    Process: \(Kernel.interruptedProcess.name)
         ID: \(Kernel.interruptedProcess.ID)

    \(message)
    ------------------------------------------
    """
    
    Kernel.interruptedProcess.log += log
//    Kernel.currentProcess.log += log
    print(log)
  }
}
