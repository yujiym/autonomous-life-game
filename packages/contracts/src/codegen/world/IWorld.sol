// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

import { IBaseWorld } from "@latticexyz/world/src/interfaces/IBaseWorld.sol";

import { IAddSystem } from "./IAddSystem.sol";
import { IClearSystem } from "./IClearSystem.sol";
import { IJoinSystem } from "./IJoinSystem.sol";
import { IMapSystem } from "./IMapSystem.sol";

/**
 * The IWorld interface includes all systems dynamically added to the World
 * during the deploy process.
 */
interface IWorld is IBaseWorld, IAddSystem, IClearSystem, IJoinSystem, IMapSystem {

}
