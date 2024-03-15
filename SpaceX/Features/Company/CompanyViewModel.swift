//
//  CompanyViewModel.swift
//  SpaceX
//
//  Created by Zac Hadjineophytou on 03/03/2024.
//

import Foundation

class CompanyViewModel : ObservableObject {
    
    @Published var company: ApiResult<Company> = ApiResult.pending
    
    let client: LaunchLibraryClient
    
    init(client: LaunchLibraryClient = LaunchLibraryClient()) {
        self.client = client
        
        self.client.getAgency() { result in
            self.company = result.transform { value in Company(response: value)}
        }
    }
}
