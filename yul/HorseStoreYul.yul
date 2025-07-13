object "HorseStoreYul" {
    code {
        // Contract Deployment
        datacopy(0, dataoffset("runtime"), datasize("runtime"))
        return(0, datasize("runtime"))
    }

    object "runtime" {
        code {
            // function dispacher
            switch selector()
            // updateHorseNumber(uint256)
            case 0xcdfead2e {
                storeNumber(decodeAsUint(0))
            }
            // readNumberOfHorses()
            case 0xe026c017 {
                returnUint(readNumber())
            }
            default {
                revert(0, 0)
            }

            function storeNumber(newNumberOfHorses) {
                // Store the new number of horses in the storage slot
                sstore(0, newNumberOfHorses)
            }

            function readNumber() -> numberOfHorses {
                // Read the number of horses from the storage slot
                numberOfHorses := sload(0)
            }

            // decoding functions
            function selector() -> s {
                s := div(calldataload(0), 0x100000000000000000000000000000000000000000000000000000000)
            }

            function decodeAsUint(offset) -> v {
                let positionInCalldata := add(4, mul(offset, 0x20))
                if lt(calldatasize(), add(positionInCalldata, 0x20)) {
                    revert(0, 0)
                }
                v := calldataload(positionInCalldata)
            }

            function returnUint(value) {
                mstore(0, value) // Store the value in memory
                return(0, 0x20) // Return 32 bytes from memory
            }
        }
    }
}