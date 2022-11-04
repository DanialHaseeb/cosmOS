//
//  Scheduler.swift
//  cosmOS
//
//  Created by Danial Haseeb on 04/11/2022.
//

extension Kernel
{
  /// The set of process IDs currently in use.
  ///
  /// It is used to ensure all process IDs are unique.
  static var IDs: Set<Process.ID> = []
  
  /// The list of all processes ever instantiated by **cosmOS**.
  static var processes: [Process] = []
  
  /// The period of time (in system clock cycles) for which a process is allowed to run in
  /// the virtual machine's preemptive multitasking system.
  static var timeQuantum = 8 // cycles
  
  /// The high-priority job queue maintained by the kernel containing processes to run.
  ///
  /// It uses a priority scheduling algorithm; dispatching processes to the processing core
  /// based on their given priorities.
  static var queue1: PriorityQueue<Process> = []
  
  /// The low-priority job queue maintained by the kernel containing processes to run.
  ///
  /// It uses a round-robin scheduling algorithm; dispatching each process to the processing core
  /// for a given time quantum.
  static var queue2: Queue<Process> = []
  
  /// The list of all processes awaiting execution on the virtual machine core.
  static var readyProcesses: [Process]
  { queue1.elements + queue2.elements }
  
  /// The processing currently executing on the virtual machine's processing core.
  static var currentProcess: Process = Kernel.task
  
  /// The process that raised the most recent interrupt during execution in the virtual machine core.
  static var interruptedProcess: Process = Kernel.task
  
  static func switchContext(to process: Process)
  {
    currentProcess.state = Core.state
    currentProcess.R = Core.R
    currentProcess.S = Core.S
    
    Core.load(process)
    currentProcess = process
  }
}
