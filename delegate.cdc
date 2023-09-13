import ExampleService from "./ExampleService.cdc"

transaction(serviceAddress: Address) {
    prepare(signer: AuthAccount) {
        let capability = signer.capabilities.storage.issue<&ExampleService.NFT>(/storage/NFT)
        let proxy = getAccount(serviceAddress).capabilities.borrow<&ExampleService.Proxy{ExampleService.ProxyPublic}>(/public/Proxy) ?? panic("Could not borrow the proxy reference")

        proxy.deposit(capability: capability)
    }
}