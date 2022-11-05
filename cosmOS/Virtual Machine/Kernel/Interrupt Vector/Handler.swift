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

    ⚠️ Interrupt raised at time: \(Clock.time)
    Process: \(Kernel.currentProcess.name)
         ID: \(Kernel.currentProcess.ID)
    
    \(message)

    """
    
    Kernel.currentProcess.log += log
    Kernel.currentProcess.state = .terminated
    Core.state = .terminated
    print(log)
  }
}
