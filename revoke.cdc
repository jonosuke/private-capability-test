transaction {
    prepare(signer: AuthAccount) {
        for controller in signer.capabilities.storage.getControllers(forPath: /storage/NFT) {
            controller.delete()
        }
    }
}