# ERC20 token transfers in sepolia network
from web3 import Web3

# Infura/Alchemy Sepolia endpoint URL
INFURA_URL = 'https://sepolia.infura.io/v3/<api_key>'

# Connect to the Sepolia network using Infura
web3 = Web3(Web3.HTTPProvider(INFURA_URL))

# Check if connected to the Sepolia test network
if web3.is_connected():
    print("Connected to Sepolia testnet.")
else:
    print("Connection failed.")
    exit()

# Replace these values with the actual sender's private key and addresses
SENDER_ADDRESS = '0x...'
SENDER_PRIVATE_KEY = '0x...'  # Keep this private and secure!
RECIPIENT_ADDRESS = '0x...'

# ERC-20 token contract address and ABI (You can get ABI from the token's source code)
# add decimals if needed
ERC20_ABI = [
    {
        "constant": False,
        "inputs": [
            {"name": "_to", "type": "address"},
            {"name": "_value", "type": "uint256"}
        ],
        "name": "transfer",
        "outputs": [{"name": "", "type": "bool"}],
        "type": "function"
    }
]

# List of token contract addresses
token_contract_addresses = [
    # the list of tokens
]

# Transaction details
tx = {
    'nonce': web3.eth.get_transaction_count(SENDER_ADDRESS),
    'to': RECIPIENT_ADDRESS,
    'value': web3.to_wei(0.01, 'ether'),  # Sending 0.01 ETH
    'gas': 21000,  # Standard gas limit for ETH transfers
    'gasPrice': web3.to_wei(10, 'gwei'),  # Gas price
    'chainId': 11155111  # Chain ID for Sepolia
}

# Define the amount of tokens to send for each token contract
AMOUNT = 100000  # Example: Sending 10 tokens (adjust as necessary)

# Function to send tokens
def send_tokens(token_contract_address, amount):
    token_contract = web3.eth.contract(address=token_contract_address, abi=ERC20_ABI)

    # Get token decimals (assuming most ERC-20 tokens have 18 decimals)
    # decimals = token_contract.functions.decimals().call()
    token_amount = amount * (10 ** 18)
    # token_amount = 1

    # Build the transaction
    nonce = web3.eth.get_transaction_count(SENDER_ADDRESS)
    transaction = token_contract.functions.transfer(
        RECIPIENT_ADDRESS,
        token_amount
    ).build_transaction({
        'chainId': 11155111,  # Chain ID for Sepolia
        'gas': 200000,  # Gas limit (adjust based on token contract's requirements)
        'gasPrice': web3.to_wei(10, 'gwei'),  # Gas price in gwei
        'nonce': nonce
    })

    # Sign the transaction
    signed_txn = web3.eth.account.sign_transaction(transaction, private_key=SENDER_PRIVATE_KEY)

    # Send the transaction
    tx_hash = web3.eth.send_raw_transaction(signed_txn.raw_transaction)
    print(f"Transaction sent for token {token_contract_address}! You can track it at https://sepolia.etherscan.io/tx/{web3.to_hex(tx_hash)}")

    # Optional: Wait for the transaction receipt
    receipt = web3.eth.wait_for_transaction_receipt(tx_hash)
    # print(f"Transaction receipt: {receipt}")

i = 1
# Loop through each token and send the same amount
for token_contract_address in token_contract_addresses:
    try:
        print(i, ':\n')
        send_tokens(token_contract_address, AMOUNT)
        i=i+1
    except Exception as e:
        print(f"Failed to send tokens for {token_contract_address}: {str(e)}")
