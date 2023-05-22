import { mudConfig } from "@latticexyz/world/register";

export default mudConfig({
  tables: {
    MapConfig: {
      keySchema: {},
      dataStruct: false,
      schema: {
        width: "uint32",
        height: "uint32",
        cell: "bytes",
      },
    },
    MaxPlayerId: {
      keySchema: {},
      schema: "uint8",
    },
    Players: {
      dataStruct: true,
      schema: {
        user: "address",
        cellPower: "uint8",
      },
    },
    CalculatedCount: {
      keySchema: {},
      schema: "uint256",
    },
  },
});
