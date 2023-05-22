import { getComponentValue } from "@latticexyz/recs";
import { awaitStreamValue } from "@latticexyz/utils";
import { ClientComponents } from "./createClientComponents";
import { SetupNetworkResult } from "./setupNetwork";

export type SystemCalls = ReturnType<typeof createSystemCalls>;

export function createSystemCalls(
  { worldSend, txReduced$, singletonEntity }: SetupNetworkResult,
  { Counter, Players, MaxPlayerId }: ClientComponents
) {
  const increment = async () => {
    const tx = await worldSend("increment", []);
    return getComponentValue(Counter, singletonEntity);
  };
  const add = async (x: number, y: number, id: number) => {
    const tx = await worldSend("add", [x, y, id]);
    await awaitStreamValue(txReduced$, (txHash) => txHash === tx.hash);
    // return getComponentValue(Counter, singletonEntity);
  };
  const join = async () => {
    const tx = await worldSend("join", []);
    await awaitStreamValue(txReduced$, (txHash) => txHash === tx.hash);
    return getComponentValue(MaxPlayerId, singletonEntity);
  };

  return {
    add,
    join,
    increment,
  };
}
