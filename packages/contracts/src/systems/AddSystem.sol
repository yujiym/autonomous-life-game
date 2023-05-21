// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import {System} from "@latticexyz/world/src/System.sol";
import {MapConfig, Players} from "../codegen/Tables.sol";

contract AddSystem is System {
  // add this method
  function add(uint32 _x, uint32 _y, uint8 _id) public {
    //reduce cell power
    uint8 _cellPower = Players.get(bytes32(uint256(_id))).cellPower;
    if (_cellPower == 0) revert("Cell power is 0");
    Players.setCellPower(bytes32(uint256(_id)), _cellPower - 1);

    // map
    (uint32 width, uint32 height, bytes memory cell) = MapConfig.get();

    bytes memory newCell = new bytes(width * height);

    for (uint32 y = 0; y < height; y++) {
      for (uint32 x = 0; x < width; x++) {
        uint8 cellValue = uint8(cell[(y * width) + x]);
        if (x == _x && y == _y) {
          if (cellValue != 0) revert("Cell is already occupied");
          cellValue = _id;
        } else {
          if (cellValue == 0) continue;
        }
        newCell[(y * width) + x] = bytes1(cellValue);
      }
    }

    MapConfig.setCell(newCell);
  }
}
