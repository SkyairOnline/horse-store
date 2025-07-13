// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {HorseStore} from "../../src/horseStoreV1/HorseStore.sol";
import {Test} from "forge-std/Test.sol";

abstract contract Base_TestV1 is Test {
    HorseStore internal horseStore;

    function setUp() public virtual {
        horseStore = new HorseStore();
    }

    function testReadValue() public view {
        uint256 initialHorses = horseStore.readNumberOfHorses();
        assertEq(initialHorses, 0);
    }

    function testWriteValue() public {
        uint256 newHorses = 5;
        horseStore.updateHorseNumber(newHorses);
        assertEq(horseStore.readNumberOfHorses(), newHorses);
    }
}