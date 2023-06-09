// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

interface IJoinSystem {
  function join() external returns (uint8 playerId_);

  function getCellPower(uint8 playerId_) external view returns (uint8 cellPower_);
}
