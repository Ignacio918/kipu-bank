// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30; // 

/// @title KipuBank
/// @author Ignacio Campos
/// @notice Contrato educativo del Módulo 2 del curso ETH KIPU
/// @dev Implementa depósitos y retiros limitados con seguridad básica

contract KipuBank {
    // ---------------------------
    // VARIABLES DE ESTADO
    // ---------------------------

    /// @notice Límite global de depósitos del banco (en wei)
    uint256 public immutable bankCap;

    /// @notice Límite máximo de retiro por transacción (en wei)
    uint256 public immutable withdrawLimit;

    /// @notice Balance total almacenado en el banco
    uint256 public totalDeposits;

    /// @notice Registro de depósitos individuales por usuario
    mapping(address => uint256) private balances;

    /// @notice Contadores
    uint256 public numDeposits;
    uint256 public numWithdrawals;

    // ---------------------------
    // EVENTOS
    // ---------------------------
    event DepositMade(address indexed user, uint256 amount);
    event WithdrawalMade(address indexed user, uint256 amount);

    // ---------------------------
    // ERRORES PERSONALIZADOS
    // ---------------------------
    error DepositLimitExceeded(uint256 attempted, uint256 remaining);
    error WithdrawLimitExceeded(uint256 attempted, uint256 maxPerTx);
    error InsufficientBalance(uint256 requested, uint256 available);
    error ZeroAmount();
    error NativeTransferFailed();

    // ---------------------------
    // MODIFICADORES
    // ---------------------------
    /// @dev Requiere un monto no nulo para funciones con parámetro amount.
    modifier nonZero(uint256 amount) {
        if (amount == 0) revert ZeroAmount();
        _;
    }

    /// @dev Requiere valor (msg.value) no nulo en funciones payable.
    modifier nonZeroMsgValue() {
        if (msg.value == 0) revert ZeroAmount();
        _;
    }

    // ---------------------------
    // CONSTRUCTOR
    // ---------------------------
    /// @param _bankCap Límite global del banco en wei
    /// @param _withdrawLimit Límite máximo por retiro en wei
    constructor(uint256 _bankCap, uint256 _withdrawLimit) {
        bankCap = _bankCap;
        withdrawLimit = _withdrawLimit;
    }

    // ---------------------------
    // FUNCIONES PÚBLICAS
    // ---------------------------

    /// @notice Permite depositar ETH al banco
    /// @dev Sigue el patrón checks-effects-interactions
    function deposit() external payable nonZeroMsgValue {
        if (totalDeposits + msg.value > bankCap) {
            revert DepositLimitExceeded(msg.value, bankCap - totalDeposits);
        }

        // effects
        balances[msg.sender] += msg.value;
        totalDeposits += msg.value;
        numDeposits++;

        // interactions (no externas acá)
        emit DepositMade(msg.sender, msg.value);
    }

    /// @notice Permite retirar ETH del banco
    /// @param amount Monto a retirar (en wei)
    /// @dev Sigue el patrón checks-effects-interactions y usa envío nativo seguro
    function withdraw(uint256 amount) external nonZero(amount) {
        if (amount > withdrawLimit) {
            revert WithdrawLimitExceeded(amount, withdrawLimit);
        }

        uint256 available = balances[msg.sender];
        if (amount > available) {
            revert InsufficientBalance(amount, available);
        }

        // effects
        balances[msg.sender] = available - amount;
        totalDeposits -= amount;
        numWithdrawals++;

        // interactions
        _payout(msg.sender, amount);

        emit WithdrawalMade(msg.sender, amount);
    }

    /// @notice Devuelve el balance del usuario llamante
    function getMyBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    /// @notice Devuelve la cantidad de depósitos y retiros
    function getStats() external view returns (uint256 deposits, uint256 withdrawals) {
        return (numDeposits, numWithdrawals);
    }

    // ---------------------------
    // FUNCIONES PRIVADAS
    // ---------------------------

    /// @dev Envía ETH de forma segura usando call.
    function _payout(address to, uint256 amount) private {
        (bool ok, ) = to.call{value: amount}("");
        if (!ok) revert NativeTransferFailed();
    }
}
