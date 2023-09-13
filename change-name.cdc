import ExampleService from "./ExampleService.cdc"

transaction(userAddress: Address, name: String) {
    prepare(signer: AuthAccount) {
        let proxy = signer.borrow<&ExampleService.Proxy>(from: /storage/Proxy) ?? panic("Could not borrow a reference to the ExampleProxy contract")

        if let capability = proxy.capabilities[userAddress] {
            if capability.check() {
                let nft = capability.borrow()!

                nft.changeName(name: name)
            } else {
                log("invalid capability")
            }
        } else {
            log("User has no capability")
        }
    }
}