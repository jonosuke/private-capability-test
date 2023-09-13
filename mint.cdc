import ExampleService from "./ExampleService.cdc"

transaction(name: String) {
    prepare(signer: AuthAccount) {
        let nft <- ExampleService.mint(name: name)

        signer.save(<-nft, to: /storage/NFT)
    }
}