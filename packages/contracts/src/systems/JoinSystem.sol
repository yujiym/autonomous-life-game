// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import {System} from "@latticexyz/world/src/System.sol";
import {MaxPlayerId, Players} from "../codegen/Tables.sol";

contract JoinSystem is System {
  uint8 public constant INIT_CELL_POWER = 12;

  function join(address _user) public returns (uint8 playerId_) {
    uint8 maxPlayerId = MaxPlayerId.get();
    uint8 nextPlayerId = maxPlayerId + 1;
    MaxPlayerId.set(nextPlayerId);
    Players.set(bytes32(uint256(nextPlayerId)), _user, INIT_CELL_POWER);
  }
}
