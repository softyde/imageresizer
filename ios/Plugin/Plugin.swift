import Foundation
import Capacitor

import func AVFoundation.AVMakeRect

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(ImageResizer)
public class ImageResizer: CAPPlugin {
    
     let DEFAULT_DIRECTORY = "DOCUMENTS"
    
    /**
     * Helper for handling errors
     */
    func handleError(_ call: CAPPluginCall, _ message: String, _ error: Error? = nil) {
      call.error(message, error)
    }
    
    /**
      * Get the SearchPathDirectory corresponding to the JS string
      */
     func getDirectory(directory: String) -> FileManager.SearchPathDirectory {
       switch directory {
       case "DOCUMENTS":
         return .documentDirectory
       case "CACHE":
         return .cachesDirectory
       default:
         return .documentDirectory
       }
     }
     
     /**
      * Get the URL for this file, supporting file:// paths and
      * files with directory mappings.
      */
     func getFileUrl(_ path: String, _ directoryOption: String) -> URL? {
       if path.starts(with: "file://") {
         return URL(string: path)
       }
       
       let directory = getDirectory(directory: directoryOption)
       
       guard let dir = FileManager.default.urls(for: directory, in: .userDomainMask).first else {
         return nil
       }
       
       return dir.appendingPathComponent(path)
     }
    
    @objc func resizeImage(_ call: CAPPluginCall) {

        guard let file = call.get("path", String.self) else {
             handleError(call, "Path must be provided and must be a string")
             return
           }
        
        let width = call.get("width", Int.self, 1000)!
        let height = call.get("height", Int.self, 1000)!
        
        let keepAspectRatio = call.get("keepAspectRatio", Bool.self, false)!
        let quality = CGFloat(call.get("quality", Float.self, 1.0)!)
        
        let directoryOption = call.get("directory", String.self, DEFAULT_DIRECTORY)!
           
        guard let fileUrl = getFileUrl(file, directoryOption) else {
            handleError(call, "Invalid path")
            return
        }
        
        guard let image = UIImage(contentsOfFile: fileUrl.path) else {
            handleError(call, "Error reading image")
            return
        }
        
        var size = CGSize(width: width, height: height);
        
        if keepAspectRatio {
            size = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(origin: .zero, size: size)).size
        }

        let renderer = UIGraphicsImageRenderer(size: size)
          let result = renderer.image { (context) in
              image.draw(in: CGRect(origin: .zero, size: size))
          }
        
        do {
            try result.jpegData(compressionQuality: quality)?.write(to: fileUrl)
        }
        catch {
            handleError(call, "Error writing image")
            return
        }
        
        call.success([
            "path": fileUrl.path
        ])
    }
}
