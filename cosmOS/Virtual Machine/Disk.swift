//
//  Disk.swift
//  cosmOS
//
//  Created by Danial Haseeb on 03/11/2022.
//

import Foundation

/// The storage mechanism of the virtual machine architecture.
class Disk
{
  /// The disk contents.
  ///
  /// These are a list of programmes that are loaded into and later executed by **cosmOS**
  /// as processes.
  static var storage: [Programme] = []
  
  /// Creates a list of programmes stored inside the virtual machine disk storage.
  ///
  /// The loading status of each programme is shown on the standard output stream.
  ///
  /// - Parameter path: The path to the directory containing **cosmOS** executables.
  @discardableResult
  init(at path: String)
  {
    let ᴜʀʟ = URL(fileURLWithPath: path, isDirectory: true)
    
    /// Extracts the file URLs from a given directory.
    /// Subdirectories are ignored.
    ///
    /// - Parameter directory: The URL of the directory from which the file URLs will be extracted.
    ///
    /// - Returns An array containing the URL of each file found in the given directory.
    func extractFileURLs(from directory: URL) -> [URL]
    {
      /* Initialise variables. */
      let fileManager = FileManager.default
      var fileURLs: [URL] = []
      let contents = try! fileManager.contentsOfDirectory(at: directory,
                                                          includingPropertiesForKeys: [])

      /* Loop over directory contents */
      for content in contents
      {
        let resourceValue = try! content.resourceValues(forKeys: [.isDirectoryKey])
        let contentIsDirectory = resourceValue.isDirectory!
        let contentIsFile = !contentIsDirectory
        
        if contentIsFile && content.lastPathComponent.first != "."
        { fileURLs.append(content) }
      }
      
      /* Output */
      return fileURLs
    }
    
    
  }
}
