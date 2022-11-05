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
  
  /// The period of time (in system clock cycles) for which a process is allowed to run in
  /// the virtual machine's preemptive multitasking system.
  static var timeQuantum = 8 // cycles
  
  /// The number of system clock cycles that have passed since the last time quantum elapsed.
  static var quantumCounter = 0 // cycles
  
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
  
  /// Stores the state of the current process, so that it can be restored and resume execution at a later point,
  /// and then restores a different, previously saved, given process.
  ///
  /// - Parameter process: The given process to which context will be switched.
  static func switchContext(to process: Process)
  {
    currentProcess.state = Core.state
    currentProcess.R = Core.R
    currentProcess.S = Core.S
    currentProcess.instruction = Core.execute
    currentProcess.log += "Loaded out of Core at \(Clock.time).\n"
    
    Core.load(process)
    currentProcess = process
  }
  
  /// Enqueues the newly created processes into their respective **cosmOS** job queues.
  static func enqueue()
  {
    while !(newProcesses.isEmpty)           // loop until no new processes:
    {
      let process = newProcesses.dequeue()! //   dequeue process
      process.state = .fetch                //   state <- fetch
      if (process.priority < 16)            //   if high priority:
      {
        queue1.enqueue(process)             //     it goes in queue1
        process.log += "Enqueued in Queue 1.\n"
      }
      else                                  //   otherwise:
      {
        queue2.enqueue(process)             //     it goes in queue2
        process.log += "Enqueued in Queue 2.\n"
      }
      processes.append(process)
    }
  }
  
  /// Controls unattended background programme execution of processes.
  static func dispatch()
  {
    func priorityDispatch()
    {
      if (Core.state == .terminated)
      {
        let nextProcess = queue1.dequeue()!
        switchContext(to: nextProcess)
      }
    }
    
    func roundRobinDispatch()
    {
      if (Core.state == .terminated)
      {
        let nextProcess = queue2.dequeue()!
        switchContext(to: nextProcess)
        quantumCounter = 0
      }
      else if (quantumCounter == timeQuantum)
      {
        let nextProcess = queue2.dequeue()!
        queue2.enqueue(currentProcess)
        switchContext(to: nextProcess)
        quantumCounter = 0
      }
      else
      { quantumCounter += 1 }
    }
    
    guard (queue1.isEmpty) else
    {
      priorityDispatch()
      return
    }
    guard (queue2.isEmpty) else
    {
      roundRobinDispatch()
      return
    }
  }
  
  static func detectInfiniteLoop()
  {
    let infinity = 10000
    if (currentProcess.time.execution > infinity)
    { Kernel.raise(Interrupt.infiniteLoop) }
  }
}
