
import Foundation

final class UserDefaultsManager {
    
    func saveCredentials(name: String, email: String) {
        let user = User(name: name, email: email)
        UserDefaults.standard.setData(encodable: user, "userData")
    }
    
    func getCredentials() -> (String, String) {
        let data = UserDefaults.standard.getData(User.self, "userData")
        return (data?.name ?? "", data?.email ?? "")
    }

}



