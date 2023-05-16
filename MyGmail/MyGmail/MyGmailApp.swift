//
//  MyGmailApp.swift
//  MyGmail
//
//  Created by Shuai Zhang on 5/8/23.
//

import SwiftUI

@main
struct MyGmailApp: App {
    @StateObject private var slideInMenuService = SlideInMenuService()
    @StateObject private var showToolBarService = ShowToolBarService()
    @StateObject private var filterService = FilterService()
    @StateObject private var inboxViewModel = InboxMailsViewModel()

    var body: some Scene {
        WindowGroup {
            Group {
                HomeView(model: inboxViewModel, showToolBarService: showToolBarService)
            }.environmentObject(slideInMenuService)
                .environmentObject(showToolBarService)
                .environmentObject(filterService)
                .slideInView(
                    isActive: $slideInMenuService.isPresented,
                    edge: .leading,
                    paddingPercentage: 0.3,
                    options:
                    SlideInViewOptions(
                        paddingColor: .gray,
                        paddingColorOpacity: 0.8
                    )
                ) {
                    SideBarMenuView(
                        model: SideMenuItemViewModel(filterService: filterService),
                        mailViewModel: inboxViewModel,
                        showToolBarService: showToolBarService,
                        slideInMenuService: slideInMenuService
                    )
                }
        }
    }
}
