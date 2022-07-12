//
import Foundation

// write to document directory and read from document directory any kind of data


extension FileManager {
   static  func getDocumentDirectory() -> URL {
        
        let paths = FileManager.default.urls(for:.documentDirectory , in: .userDomainMask)
        
        return paths[0]
        
    }
    
    static  func writeToDocumentDirectory  <T: Codable> ( data  : T , withFileName : String  , withProtectionEnabled fileProtectionEnabled : Bool ) {
        
        let url = getDocumentDirectory().appendingPathComponent(withFileName)
        
      
        let encoder = JSONEncoder()
        do {
            
           let encoded = try encoder.encode(data)
            
           
          
            
            if fileProtectionEnabled {
                
                try encoded.write(to: url, options: [.atomic, .completeFileProtection])
                
            }
            
            else {
            try encoded.write(to: url)
            }
            
           
        }
        catch {
            print(error.localizedDescription)
            print("Unablen to save Data")
        }
    }
        
        
    
    
  static  func readFromDocumentDirectory <T: Codable>(withFileName : String  ) -> T? {
        
        let url = FileManager.getDocumentDirectory().appendingPathComponent(withFileName)
        do {
        let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
    }
        catch {
            print(error.localizedDescription)
            
            return nil
        }
}

}
