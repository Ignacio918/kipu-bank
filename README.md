# 🏦 KipuBank  

Contrato inteligente educativo del **Módulo 2 del curso ETH KIPU**, implementado en Solidity.  
Simula un banco simple donde los usuarios pueden **depositar y retirar ETH** bajo ciertas restricciones de seguridad.  

---

## 📋 Descripción  

KipuBank permite a cualquier usuario:  

- Depositar ETH en su cuenta dentro del contrato.  
- Retirar ETH, pero con un **límite fijo por transacción** (`withdrawLimit`).  
- Garantizar que el contrato no supere un **límite global de depósitos** (`bankCap`).  
- Llevar un registro de:  
  - El balance individual de cada usuario.  
  - El número total de depósitos y retiros.  
- Emitir eventos (`DepositMade` y `WithdrawalMade`) para trazar operaciones en la blockchain.  
- Revertir operaciones inválidas con **errores personalizados**.  

Este contrato es la **base de portafolio** del curso: en módulos futuros se ampliará con nuevas funciones.  

---

## 🛠️ Estructura del repositorio  

kipu-bank/
├── contracts/
│ └── KipuBank.sol # Contrato inteligente principal
├── README.md # Documentación del proyecto
├── LICENSE # Licencia MIT


---

## ⚙️ Requisitos  

- [Remix IDE](https://remix.ethereum.org) o cualquier entorno de desarrollo Solidity.  
- **Solidity ^0.8.30**.  
- Testnet (ej. **Sepolia**) para el despliegue final.  
- Fondos de faucet en testnet para interactuar.  

---

## 🚀 Despliegue  

1. Abrir **Remix IDE**.  
2. Crear la carpeta `contracts/` y dentro un archivo `KipuBank.sol`.  
3. Copiar el código del contrato provisto.  
4. Compilar con compilador `0.8.30+commit.73712a01` y EVM version **Paris**.  
5. En la pestaña *Deploy & Run Transactions*:  
   - Seleccionar **Injected Provider – MetaMask** (conectado a Sepolia).  
   - Ingresar los parámetros del constructor:  
     - `_bankCap`: límite global de depósitos (en wei).  
     - `_withdrawLimit`: límite de retiro por transacción (en wei).  
   - Hacer click en **Deploy**.  
6. Verificar el contrato en **Etherscan Sepolia** pegando el código fuente.  

---

## 💻 Interacción  

Una vez desplegado, el contrato expone las siguientes funciones:  

### 1. `deposit() external payable`  
- Permite depositar ETH en el contrato.  
- Requiere enviar valor en `msg.value`.  
- Emite el evento `DepositMade`.  

**Ejemplo (Remix):**  
Enviar `0.1 ETH` en el campo **Value** y ejecutar `deposit`.  

---

### 2. `withdraw(uint256 amount) external`  
- Retira ETH del contrato hacia el usuario llamante.  
- Reglas:  
  - `amount <= withdrawLimit`.  
  - `amount <= balance` del usuario.  
- Emite el evento `WithdrawalMade`.  

**Ejemplo:**  
Si tu balance es `0.1 ETH` y el límite de retiro es `0.05 ETH`, podés retirar `0.05 ETH` por transacción.  

---

### 3. `getMyBalance() external view returns (uint256)`  
- Devuelve el balance individual del usuario que llama.  

---

### 4. `getStats() external view returns (uint256, uint256)`  
- Devuelve la cantidad total de depósitos y retiros.  

---

## 📊 Ejemplo de uso en testnet  

Despliegue con:  
- `_bankCap = 1 ETH (1000000000000000000 wei)`.  
- `_withdrawLimit = 0.1 ETH (100000000000000000 wei)`.  

Ejemplo de interacciones:  
- Usuario A deposita `0.2 ETH` → evento **DepositMade** emitido.  
- Usuario A intenta retirar `0.5 ETH` → falla con **Exceeds withdraw limit**.  
- Usuario A retira `0.1 ETH` → evento **WithdrawalMade** emitido.  

---

## 📍 Dirección del contrato desplegado  

👉 [`0xD75EE3cD48a94d2Af683F1De7766655153B43f93`](https://sepolia.etherscan.io/address/0xD75EE3cD48a94d2Af683F1De7766655153B43f93)  

Ejemplo de transacción exitosa (Withdraw):  
🔗 [Tx Hash en Sepolia](https://sepolia.etherscan.io/tx/0xb771f7a4c7b1876657a8a7cb1a5f8775626ddb9ceee1183bd4a66322650db697)  

---

## 👤 Autor  

Ignacio Campos  
Curso ETH KIPU – Módulo 2  

---

## 📄 Licencia  

Este proyecto está bajo la licencia **MIT**.  
Ver el archivo `LICENSE` para más detalles.  
