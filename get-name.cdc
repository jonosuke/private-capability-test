import ExampleService from "./ExampleService.cdc"

pub fun main(address: Address): String {
    let nft = getAuthAccount(address).borrow<&ExampleService.NFT>(from: /storage/NFT)!
    return nft.name
}