# Private Capabilityのテスト
1. エミュレーターの起動
```
flow emulator -v
```
2. デプロイ
```
flow project deploy
```
3. テストアカウントをエミュレータに作成
```
flow accounts create
Enter an account name: jonosuke
Use the arrow keys to navigate: ↓ ↑ → ← 
? Choose a network: 
  ▸ Emulator
    Testnet
    Mainnet
```
4. ミント
```
flow transactions send mint.cdc Jonosuke --signer=jonosuke
```
5. ミントしたNFTの名前を確認
```
flow scripts execute get-name.cdc テストアカウントのアドレス

Result: "Jonosuke"
```
6. emulator-accountにNFTの権限を渡す
```
flow transactions send delegate.cdc f8d6e0586b0a20c7 --signer=jonosuke
```
7. emulator-accountの署名でテストアカウントのNFTを更新
```
flow transactions send change-name.cdc テストアカウントのアドレス JoJonosuke --signer=emulator-account
```
8. NFTの名前が更新された事を確認
```
flow scripts execute get-name.cdc テストアカウントのアドレス

Result: "JoJonosuke"
```
9. emulator-accountに渡した権限の削除
```
flow transactions send revoke.cdc --signer=jonosuke
```
10. emulator-accountの署名でテストアカウントのNFTを更新出来ない事を確認
```
flow transactions send change-name.cdc テストアカウントのアドレス Jononosuke --signer=emulator-account
```
エミュレーターのログに、```LOG: "invalid capability"```と出力されている事を確認する。
