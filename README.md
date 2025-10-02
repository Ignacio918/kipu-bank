# KipuBank

## 📌 Descripción
Este proyecto corresponde al **Módulo 2 del curso ETH KIPU**.  
Implementa un contrato inteligente en **Solidity** que simula una bóveda bancaria con depósitos y retiros de ETH bajo condiciones de seguridad y límites definidos.  

El objetivo es aplicar buenas prácticas de desarrollo en Web3:  
- Uso de variables **inmutables** y **constantes**.  
- Manejo de **mappings** para registrar información.  
- Implementación de **eventos** y **errores personalizados**.  
- Patrón **checks-effects-interactions** para seguridad.  
- Uso de **modificadores** para validar condiciones.  

---

## ⚙️ Funcionalidades principales
- Los usuarios pueden **depositar ETH** en su bóveda personal.  
- Los usuarios pueden **retirar ETH**, con un **límite fijo por transacción**.  
- Existe un **límite global de depósitos (bankCap)** definido en el despliegue.  
- Cada depósito y retiro genera un **evento** en la blockchain.  
- Se lleva un registro del **número de depósitos y retiros**.  
- Incluye **función external payable**, **función privada** y **función view**.  

---

## 🛠️ Estructura del repositorio
kipu-bank/
 ├── contracts/
 │    └── KipuBank.sol   # Contrato inteligente principal
 ├── README.md           # Documentación del proyecto

---

## 🚀 Despliegue
### Requisitos previos
- Navegador con [Metamask](https://metamask.io/) instalado.  
- Conexión a una testnet (ej: **Sepolia**).  
- ETH de faucet para gas.  

### Pasos
1. Compilar el contrato con versión `^0.8.x` en [Remix](https://remix.ethereum.org/).  
2. Desplegar en la testnet desde Remix usando la wallet conectada.  
3. Guardar la **dirección del contrato** generado.  
4. Verificar el código en un explorador de bloques como [Etherscan](https://sepolia.etherscan.io/).  

---

## 🖥️ Interacción con el contrato
Una vez desplegado, el contrato permite:  

- **depositarETH()** → Deposita ETH en la bóveda del usuario.  
- **retirarETH()** → Retira fondos hasta el límite permitido.  
- **getBalance()** → Consulta el saldo de un usuario.  
- **getStats()** → Devuelve la cantidad de depósitos y retiros.  

Los eventos `DepositoRealizado` y `RetiroRealizado` quedan registrados en la blockchain para trazabilidad.  

---

## 📍 Dirección del contrato desplegado
👉 Completar acá con la dirección al desplegar en testnet y el link al explorador con el código verificado.  

---

## ✍️ Autor
Ignacio Campos  
Curso ETH KIPU – Módulo 2
