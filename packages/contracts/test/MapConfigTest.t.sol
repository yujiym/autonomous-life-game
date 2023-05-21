// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import "forge-std/Test.sol";
import {MudV2Test} from "@latticexyz/std-contracts/src/test/MudV2Test.t.sol";

import {IWorld} from "../src/codegen/world/IWorld.sol";
import {MapConfig, MapConfigTableId} from "../src/codegen/Tables.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract MapConfigTest is MudV2Test {
  using Strings for uint256;

  IWorld public world;

  function setUp() public override {
    super.setUp();
    world = IWorld(worldAddress);

    // uint8[10][10] memory map = [
    //   [1, 1, 1, 0, 0, 0, 0, 2, 2, 0],
    //   [1, 0, 1, 0, 0, 0, 3, 1, 0, 0],
    //   [1, 1, 1, 0, 0, 0, 3, 0, 0, 0],
    //   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    //   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    //   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    //   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    //   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    //   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    //   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    // ];

    // uint32 height = uint32(map.length);
    // uint32 width = uint32(map[0].length);
    // bytes memory cell = new bytes(width * height);

    // for (uint32 y = 0; y < height; y++) {
    //   for (uint32 x = 0; x < width; x++) {
    //     uint8 cellValue = map[y][x];
    //     if (cellValue == 0) continue;

    //     cell[(y * width) + x] = bytes1(cellValue);
    //   }
    // }

    // MapConfig.set(world, width, height, cell);
  }

  function test_calculate() public {
    uint32 width;
    uint32 height;
    bytes memory cell;
    (width, height, cell) = MapConfig.get(world);
    _consoleCell(width, height, cell);
    world.calculate();
    (width, height, cell) = MapConfig.get(world);
    _consoleCell(width, height, cell);
  }

  function _consoleCell(uint32 width, uint32 height, bytes memory cell) private view {
    console2.log("+++++++++++++++++++++++++++++++++");
    for (uint32 y = 0; y < height; y++) {
      string memory line = "";
      for (uint32 x = 0; x < width; x++) {
        uint8 cellValue = uint8(cell[(y * width) + x]);
        if (cellValue == 0) {
          line = string(abi.encodePacked(line, "0"));
        } else {
          line = string(abi.encodePacked(line, uint256(cellValue).toString()));
        }
      }
      console2.log(line);
    }
  }
}
