//
//  File.swift
//  
//
//  Created by tu on 2020/4/18.
//
import Files
import IkigaJSON
import Foundation
import Zip
struct ImageSetContent: Codable {
    let images: [ImageInfo]
}
struct ImageInfo: Codable {
    let filename: String
    let scale: String
}
let workFolderName = "CustomizableOptions"
let workFolder = try! Folder(path: Folder.current.path + workFolderName)
let outputFolderName =  "output"
let outputFolderPath = Folder.current.path + outputFolderName
try? Folder(path: outputFolderPath).delete()
////Bags
for subfolder in workFolder.subfolders {
    for subsubFolder in subfolder.subfolders {
        let desFileName = subsubFolder.name.components(separatedBy: ".imageset").first!
        let contentsData = try! File(path: subsubFolder.path + "Contents.json").read()
        let contents = try! IkigaJSONDecoder().decode(ImageSetContent.self, from: contentsData)
        for imageInfo in contents.images {
            let destFolderPath = "\(outputFolderName)/\(workFolderName)\(imageInfo.scale)/\(subfolder.name)"
            let destFolder = try! Folder.current.createSubfolderIfNeeded(at: destFolderPath)
            let destFile = try! subsubFolder.file(named: imageInfo.filename).copy(to: destFolder)
            try! destFile.rename(to: desFileName)
            
        }
    }
}
for subfolder in try! Folder(path: outputFolderPath).subfolders {
    print(subfolder.parent!.url)
    try! Zip.zipFiles(paths: [subfolder.url], zipFilePath: subfolder.parent!.url.appendingPathComponent(subfolder.name+".zip"), password: nil, progress: nil)
}

