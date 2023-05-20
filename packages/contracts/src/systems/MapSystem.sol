// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import {System} from "@latticexyz/world/src/System.sol";
import {MapConfig} from "../codegen/Tables.sol";

contract MapSystem is System {
  // add this method
  function add(uint32 _x, uint32 _y, uint8 _id) public {
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

  function calculate() public {
    (uint32 width, uint32 height, bytes memory cell) = MapConfig.get();
    bytes memory newCell = _calculate(width, height, cell);
    MapConfig.setCell(newCell);
  }

  function _calculate(uint32 width, uint32 height, bytes memory cell) internal view returns (bytes memory newCell) {
    newCell = new bytes(width * height);

    for (uint32 y = 0; y < height; y++) {
      for (uint32 x = 0; x < width; x++) {
        // count neighbours
        uint numLiveNeighbours = 0;
        for (int32 j = -1; j <= 1; j++) {
          int32 yy = int32(y) + j;
          if (yy >= int32(height) || yy < 0) continue; //out of map
          for (int32 i = -1; i <= 1; i++) {
            if (i == 0 && j == 0) continue; //center cell is self
            int32 xx = int32(x) + i;
            if (xx >= int32(width) || xx < 0) continue; //out of map
            uint8 neighbourValue = uint8(cell[(uint32(yy) * width) + uint32(xx)]);
            if (neighbourValue == 0) continue;
            //TODO memory cellValue to calculate Dominant Neighbor
            numLiveNeighbours++;
          }
        }
        // console2.log(numLiveNeighbours);
        uint8 cellValue = uint8(cell[(uint32(y) * width) + uint32(x)]);
        //born
        if (cellValue == 0) {
          if (numLiveNeighbours == 3) {
            newCell[(y * width) + x] = bytes1(uint8(1));
          }
        } else {
          if (numLiveNeighbours == 2 || numLiveNeighbours == 3) {
            //live
            newCell[(y * width) + x] = bytes1(uint8(1));
          }
        }
      }
    }
  }
}
