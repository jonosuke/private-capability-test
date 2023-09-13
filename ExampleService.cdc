pub contract ExampleService {
    pub resource NFT {
        pub let id: UInt64
        pub var name: String

        pub fun changeName(name: String) {
            self.name = name
        }

        init(name: String) {
            self.id = self.uuid
            self.name = name
        }
    }

    pub resource interface ProxyPublic {
        pub fun deposit(capability: Capability<&NFT>) {
            pre {
                capability.check(): "This capability is invalid!"
            }
        }
    }

    pub resource Proxy: ProxyPublic {
        pub var capabilities: {Address: Capability<&NFT>}

        pub fun deposit(capability: Capability<&NFT>) {
            let nft = capability.borrow() ?? panic("Could not borrow the NFT!")
            self.capabilities[nft.owner!.address] = capability
        }

        init() {
            self.capabilities = {}
        }
    }

    pub fun createProxy(): @Proxy {
        return <- create Proxy()
    }

    pub fun mint(name: String): @NFT {
        return <- create NFT(name: name)
    }

    init() {
        let proxy <- self.createProxy()

        self.account.save(<-proxy, to: /storage/Proxy)

        let capability = self.account.capabilities.storage.issue<&ExampleService.Proxy{ExampleService.ProxyPublic}>(/storage/Proxy)

        self.account.capabilities.publish(capability, at: /public/Proxy)
    }
}