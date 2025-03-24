module Documents
  class Certificate < ApplicationRecord
    belongs_to :document
    belongs_to :corporation



    def issue_certificate
      client = Eth::Client.create("https://ethereum-sepolia-rpc.publicnode.com")

      key = Eth::Key.new(priv: corporation.private_key)
      data = document.sha256
      nonce = client.get_nonce(key.address)

      tx = Eth::Tx.new({
        chain_id: Eth::Chain::SEPOLIA,
        nonce: nonce,
        priority_fee: 1.5 * Eth::Unit::GWEI,
        max_gas_fee: 20 * Eth::Unit::GWEI,
        gas_limit: 100_000,
        to: corporation.public_key,
        from: key.address,
        data: data
      })

      tx.sign(key)

      payload = {
        jsonrpc: "2.0",
        method: "eth_sendRawTransaction",
        params: [ "0x" + tx.hex ],  # Make sure to add "0x" prefix
        id: Time.now.to_i
      }
      debugger
      response = client.send_request(payload.to_json)
      result = JSON.parse(response)
      tx_hash = result["result"]

      update(
        tx_hash: tx_hash,
        from_address: key.address.to_s,
        to_address: corporation.public_key,
        data: document.sha256,
        gas_limit: tx.gas_limit.to_s,
        max_fee_per_gas: tx.max_fee_per_gas.to_s,
        max_priority_fee_per_gas: tx.max_priority_fee_per_gas.to_s,
        status: 1
      )
    end
  end
end
