//
//  DS+FileStorage.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 29/11/24.
//

import Foundation

enum FileStorage { }

extension FileStorage {
    
    // - MARK: Functional Requirements
    /// - File Upload / Download
    /// - File Sharing
    /// - Folder Management
    /// - User Authentication / Authorization
    /// - Search files (by name, type, tags )
    
    // - MARK: Non Functional Requirements
    /// - High Availability
    /// - Scalability (millions of users & files)
    /// - Consistance (data across servers)
    /// - Security (data should be stored securely)
    ///
    /// `Optimization` (chunks)
    /// - editing a file and reuploading is costly (if file is big in size)
    /// - creates latency and consumes more time to upload the file again
    /// - requires more bandwidth if we need to maintain the history of the file (like google docs)
    /// - Solution is we can break the file into multiple chunks
    /// - metadata file caries the chunk infromation, indexes etc. it has to be syncroized in the server and shared across the devices
    /// - when multiple device edit the same file at time, then we need a syncornizer to queue the process
    ///
    ///  if a file has 4 chunks and the 3rd chunk is modified, the following happens.
    ///  A new chunk is created for the modified part (chunk 3) with a new chunk ID or hash.
    ///  `Version 1`: Chunks [Chunk1_v1, Chunk2_v1, Chunk3_v1, Chunk4_v1]
    ///  `Version 2`: Chunks [Chunk1_v1, Chunk2_v1, Chunk3_v2, Chunk4_v1]
    
    // - MARK: Capacity Esitmation
    /// Active users - 1M
    /// Avg file size - 10MB
    /// Avg files / user - 100
    /// Total Storage = 1M * 100 * 10MB - 1000TB
    ///
    /// Search Index:
    /// Each file has 5 tags to be searched ~100 byes / tag
    /// Total = 1M * 100 * 5 * 100 = 50GB
    
    // - MARK: Api Implementation
    /// POST: /api/folders - create folder
    /// PATCH: /api/files/{fileId}/move
    /// PATCH: /api/folders/{folderId}/move - move folder inside another folder
    ///
    /// POST: /api/files/upload
    /// GET: /api/files/{fileId}
    ///
    /// POST: /api/files/share - share files with user
    /// PATCH: /api/files/share/update - add/remove users
    ///
    /// POST: /api/files/search

    struct User {
        let userId: String = UUID().uuidString
        let name: String
        let email: String
    }
    
    struct File {
        let fileId: String = UUID().uuidString
        let name: String // name, type, size, id, ownerId, and sharedId
        let type: String // pdf, image
        let size: Int // in bytes
        let createAt: Date = Date()
    
        /// ForeignKeys
        let ownerId: String // should contain owner ?
        var folderId: String?
    }
    
    struct Chunk {
        let chunkId: String = UUID().uuidString
        let url: String
        let createdAt: Date
        /// FK
        let fileId: String
    }
    
    /// Instead of polluting file with shared users,
    /// New entity has been created to manage those
    struct SharedFile {
        let id: String = UUID().uuidString
        
        /// FK
        let fileId: String
        var sharedWith = [String]()
    }
    
    /// A folder can contain folders and files
    ///
    /// RootFolder
    ///   - file_test
    ///   - FolderA
    ///     - fileA
    ///   - FolderB
    struct Folder {
        let folderId: String = UUID().uuidString
        let folderName: String
        let createdAt: Date
        
        /// ForeignKeys
        var parentFolderId: String?
        var ownerId: String?
    }
    
    // - MARK: Components / Services
    class FolderService {
        var folders = [String: Folder]()
        
        func createFolder(name: String, ownerId: String) -> Folder {
            let folder = Folder(folderName: name, createdAt: Date(), ownerId: ownerId)
            folders[folder.folderId] = folder
            return folder
        }
        
        func getFolder(forFolderId folderId: String) -> Folder? {
            return folders[folderId]
        }
    }
    
    class FileService {
        var files = [String: File]()
        var sharedFiles = [String: SharedFile]() // fileId_sharedFile
        
        func uploadFile(name: String, type: String = "pdf", size: Int, ownderId: String) -> File {
            let file = File(
                name: name,
                type: type,
                size: size,
                ownerId: ownderId
            )
            files[file.fileId] = file
            return file
        }
        
        func getFile(forFileId fileId: String) -> File? {
            return files[fileId]
        }
        
        func shareFile(fileId: String, userIds: [String]) {
            let sharedFile = SharedFile(fileId: fileId, sharedWith: userIds)
            sharedFiles[fileId] = sharedFile
        }
    }
    
    // - MARK: System Design Implementation
    class FileManagementSystem {
        let fileService = FileService()
        let folderService = FolderService()
        
        // implement upload functionality
        // implement download functionality
        // implement share functionality
    }
}
