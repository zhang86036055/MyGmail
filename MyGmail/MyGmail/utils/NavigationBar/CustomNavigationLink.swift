/* * Copyright 2023 Simon Zhang. All rights reserved. */

import SwiftUI

struct CustomNavigationLink<Label: View, Destination: View>: View {
    let destination: Destination
    let label: Label
    init(destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }

    var body: some View {
        NavigationLink(
            destination: CustomNavBarContainerView(content: {
                destination
            })
            .navigationBarHidden(true),

            label: {
                label
            })
    }
}

struct CustomNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView {
            CustomNavigationLink(
                destination: Text("Destination"))
            {
                Text("Click ME")
            }
        }
    }
}
