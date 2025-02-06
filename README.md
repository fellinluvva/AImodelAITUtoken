# AImodelAITUtoken


## **Overview**
The AI Model Marketplace is a decentralized platform that allows users to list and purchase AI models using the custom ERC-20 token **AITU2328**. The marketplace leverages blockchain technology to handle secure transactions and provides a seamless user interface for interaction.

---

## **Features**

1. **ERC-20 Token (AITU2328):**
   - Implements an ERC-20 token named **AstanaITUniversity_se2328**.
   - Includes functionality for tracking recent transfers with detailed logs.

2. **Marketplace Functionality:**
   - List AI models for sale.
   - Purchase AI models using the **AITU2328** token.
   - Display all available models with their details (name, description, price, seller).

3. **Wallet Integration:**
   - Connects to MetaMask for wallet and blockchain interaction.
   - Displays token balances for connected wallets.

4. **Backend API:**
   - Stores and retrieves information about AI models.
   - Handles file uploads for AI models.

---

## **Project Structure**

```
AImodelAITUtoken/
├── contracts/               # Solidity smart contracts
│   └── AstanaITUniversity_se2328.sol  # ERC-20 token contract
├── public/                  # Frontend static files
│   ├── app.js               # Frontend logic
│   ├── index.html           # Main UI
│   └── styles.css           # Styling for the UI
├── scripts/                 # Deployment scripts for smart contracts
│   └── deploy.js
├── test/                    # Unit tests for smart contracts
├── uploads/                 # Directory for storing uploaded AI models
├── server.js                # Backend server
├── hardhat.config.js        # Hardhat configuration for deployment
├── package.json             # Dependencies and scripts
├── .env                     # Environment variables (private keys, RPC URLs)
└── README.md                # Project documentation
```

---

## **Setup Instructions**

### **1. Prerequisites**
- Node.js v16+ installed
- MetaMask extension installed
- Hardhat installed globally:
  ```bash
  npm install --save-dev hardhat
  ```
- Configure a wallet with Holesky testnet and obtain test ETH.

### **2. Installation**
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd AImodelAITUtoken
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Create a `.env` file in the root directory:
   ```plaintext
   HOLESKY_RPC_URL=<Your Holesky RPC URL>
   PRIVATE_KEY=<Your Wallet Private Key>
   ```

### **3. Smart Contract Deployment**
1. Compile the contract:
   ```bash
   npx hardhat compile
   ```
2. Deploy the contract to Holesky:
   ```bash
   npx hardhat run scripts/deploy.js --network holesky
   ```
3. Note the deployed contract address and update it in `app.js`:
   ```javascript
   const tokenAddress = "<Deployed Token Address>";
   ```

### **4. Running the Backend**
1. Start the backend server:
   ```bash
   node server.js
   ```
2. Backend runs on `http://localhost:3000`.

### **5. Running the Frontend**
1. Serve the frontend files:
   ```bash
   cd public
   npx http-server -p 8080
   ```
2. Access the application at `http://localhost:8080`.

---

## **Usage**

### **1. Connecting Wallet**
- Open the application and click `Connect MetaMask`.
- Approve the connection request in MetaMask.
- Your wallet address and token balance will appear on the UI.

**Screenshot:**
![image](https://github.com/user-attachments/assets/50d8148a-1bb4-43ca-9d82-970eefa059b8)


### **2. Creating a Model Listing**
1. Fill in the details for the model:
   - Name
   - Description
   - Price in AITU tokens
   - Upload a file.
2. Click `Create Listing` to add the model to the marketplace.

**Screenshots:**
- **Form View:**
![image](https://github.com/user-attachments/assets/e7a6b55c-18fe-4c6d-88b9-2f10abf8626c)
- **Model Created:**
![image](https://github.com/user-attachments/assets/dd4235b7-b5ed-48c3-b057-b22d80bef76c)
![image](https://github.com/user-attachments/assets/021bc171-86af-42cb-9c32-b625d987271d)


### **3. Buying a Model**
1. Browse the list of available models.
2. Click `Buy` on the desired model.
3. Confirm the transaction in MetaMask.

**Screenshots:**
- **Transaction Request in MetaMask:**
![image](https://github.com/user-attachments/assets/a7ceb44b-a4af-4629-9806-4ac9aedcff4c)
- **Purchase Confirmation:**
![image](https://github.com/user-attachments/assets/c24ab69e-7982-45bd-9809-398e3c3ae57f)

4. After a successful purchase:
   - The buyer’s token balance will update.
   - The model listing will reflect the transaction.

**Screenshots:**
- **Updated Balance:**
![image](https://github.com/user-attachments/assets/ad16fafb-556e-4f8f-9949-653a9e33065d)
![image](https://github.com/user-attachments/assets/83ebc4ec-a06b-408a-bb29-dd23e47d5bf6)
![image](https://github.com/user-attachments/assets/d0b87109-cf46-4ec2-bab3-6f4e20df883a)
Attention to wallet addresses and their balances
---

## **API Endpoints**

### **1. GET /api/getModels**
- **Description:** Retrieves all listed models.
- **Response:**
  ```json
  [
    {
      "name": "Example Model",
      "description": "A sample AI model",
      "price": "500",
      "seller": "0x...",
      "filePath": "uploads/<filename>"
    }
  ]
  ```

### **2. POST /api/createModel**
- **Description:** Adds a new model listing.
- **Request Body:** FormData containing:
  - `name`, `description`, `price`, `file`, `seller`

---

## **Screenshots**

### **1. Wallet Connected**
![image](https://github.com/user-attachments/assets/db328046-70ce-42dd-b5f7-b082b93c3bdf)

### **2. Creating a Model Listing**
![image](https://github.com/user-attachments/assets/591e6b08-935f-4a3c-859a-ec60bb4ee0c0)

### **3. Model Listing Created**
![image](https://github.com/user-attachments/assets/236d96c8-ab44-4562-839b-d63e722f8e2b)

### **4. Buying a Model**
![image](https://github.com/user-attachments/assets/f01dcd92-4d68-4b80-8807-64214fa4bed2)

### **5. Purchase Confirmation**
![image](https://github.com/user-attachments/assets/682c7b61-b4f6-4de8-ac54-0bf4c3664c57)

### **6. Updated Balance**
![image](https://github.com/user-attachments/assets/95d50449-2770-432d-822e-db9b4ec1ba7b)
![image](https://github.com/user-attachments/assets/9f83e94f-0e53-42d3-b92b-11a75a12d7ca)
![image](https://github.com/user-attachments/assets/d7c69759-747e-43d1-8091-87c0438bad68)

### **7. Model Status Updated to Sold**
![image](https://github.com/user-attachments/assets/2143e558-d459-4a97-be20-c6ccb6d21688)

---

## **Technologies Used**

- **Frontend:** HTML, CSS, JavaScript
- **Backend:** Node.js, Express
- **Blockchain:** Solidity, Hardhat, MetaMask
- **Storage:** Multer for file uploads

---

## **Testing**

1. Run unit tests for the smart contract:
   ```bash
   npx hardhat test
   ```
2. Ensure all API endpoints work correctly using Postman or curl.

---

## **Contributors**
- Azamat
- Marlen
- Gulzhan

---

## **License**
This project is licensed under the MIT License.

