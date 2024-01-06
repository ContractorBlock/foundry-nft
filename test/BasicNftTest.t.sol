// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNFT public basicNFT;
    address public USER = makeAddr("user");
    string public constant PUG =
        "ipfs://QmYdD4NWtd8cYRbos82HhKJFnuJEEdLGuQNELt41HxQsxT?filename=NFTmetadata.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNFT = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory correctName = "Dogie";
        string memory actualName = basicNFT.name();

        assert(
            keccak256(abi.encodePacked(correctName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNFT.mintNft(PUG);

        assert(basicNFT.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(PUG)) ==
                keccak256(abi.encodePacked(basicNFT.tokenURI(0)))
        );
    }
}
