// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {DeployMoodNft} from "../script/DeployMoodNft.s.sol";

contract MoodNftTest is Test {
    MoodNft public moodNft;
    string constant NFT_NAME = "Mood NFT";
    string constant NFT_SYMBOL = "MN";
    DeployMoodNft public deployer;

    string public constant SAD_SVG_URI =
        "data:application/json;base64,eyJuYW1lIjoiTW9vZCBORlQiLCAiZGVzY3JpcHRpb24iOiJBbiBORlQgdGhhdCByZWZsZWN0cyB0aGUgbW9vZCBvZiB0aGUgb3duZXIsIDEwMCUgb24gQ2hhaW4hIiwgImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogIm1vb2RpbmVzcyIsICJ2YWx1ZSI6IDEwMH1dLCAiaW1hZ2UiOiJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBEOTRiV3dnZG1WeWMybHZiajBpTVM0d0lpQmxibU52WkdsdVp6MGlhWE52TFRnNE5Ua3RNU0kvUGdvOGMzWm5JR2hsYVdkb2REMGlPREF3Y0hnaUlIZHBaSFJvUFNJNE1EQndlQ0lnZG1WeWMybHZiajBpTVM0eElpQnBaRDBpVEdGNVpYSmZNU0lnZUcxc2JuTTlJbWgwZEhBNkx5OTNkM2N1ZHpNdWIzSm5Mekl3TURBdmMzWm5JaUI0Yld4dWN6cDRiR2x1YXowaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1UazVPUzk0YkdsdWF5SWdDZ2tnZG1sbGQwSnZlRDBpTUNBd0lEUTNNeTQ1TXpVZ05EY3pMamt6TlNJZ2VHMXNPbk53WVdObFBTSndjbVZ6WlhKMlpTSStDanhqYVhKamJHVWdjM1I1YkdVOUltWnBiR3c2STBaR1F6RXdSVHNpSUdONFBTSXlNell1T1RZM0lpQmplVDBpTWpNMkxqazJOeUlnY2owaU1qTTJMamsyTnlJdlBnbzhaejRLQ1R4d1lYUm9JSE4wZVd4bFBTSm1hV3hzT2lNek16TXpNek03SWlCa1BTSk5NelUyTGpZM01Td3pOVFF1TVdNdE5qWXVNakkyTFRZM0xqWXhPQzB4TnpRdU1qVTFMVFkzTGpNek55MHlOREF1TURrMkxEQXVOekF6Q2drSll5MDRMak00T1N3NExqWTJOaXcwTGpneU55d3lNUzQ1TVRJc01UTXVNakkzTERFekxqSXlOMk0xT0M0NE55MDJNQzQ0TXl3eE5UUXVNemcyTFRZeExqSXdOQ3d5TVRNdU5qUXhMVEF1TnpBelF6TTFNUzQ0T1RZc016YzFMamsyTERNMk5TNHhNVFlzTXpZeUxqY3lNU3d6TlRZdU5qY3hMRE0xTkM0eENna0pURE0xTmk0Mk56RXNNelUwTGpGNklpOCtDZ2s4WTJseVkyeGxJSE4wZVd4bFBTSm1hV3hzT2lNek16TXpNek03SWlCamVEMGlNVFkwTGprek9DSWdZM2s5SWpFMU5TNHlNeklpSUhJOUlqTTNMakl4TmlJdlBnb0pQR05wY21Oc1pTQnpkSGxzWlQwaVptbHNiRG9qTXpNek16TXpPeUlnWTNnOUlqTXdOUzQyTmpjaUlHTjVQU0l4TlRVdU1qTXlJaUJ5UFNJek55NHlNVFlpTHo0S1BDOW5QZ284TDNOMlp6ND0ifQ==";
    string public constant HAPPY_SVG_URI =
        "data:application/json;base64,eyJuYW1lIjoiTW9vZCBORlQiLCAiZGVzY3JpcHRpb24iOiJBbiBORlQgdGhhdCByZWZsZWN0cyB0aGUgbW9vZCBvZiB0aGUgb3duZXIsIDEwMCUgb24gQ2hhaW4hIiwgImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogIm1vb2RpbmVzcyIsICJ2YWx1ZSI6IDEwMH1dLCAiaW1hZ2UiOiJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBEOTRiV3dnZG1WeWMybHZiajBpTVM0d0lpQmxibU52WkdsdVp6MGlhWE52TFRnNE5Ua3RNU0kvUGlBOGMzWm5JR2hsYVdkb2REMGlPREF3Y0hnaUlIZHBaSFJvUFNJNE1EQndlQ0lnZG1WeWMybHZiajBpTVM0eElpQnBaRDBpVEdGNVpYSmZNU0lnZUcxc2JuTTlJbWgwZEhBNkx5OTNkM2N1ZHpNdWIzSm5Mekl3TURBdmMzWm5JaUI0Yld4dWN6cDRiR2x1YXowaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1UazVPUzk0YkdsdWF5SWdkbWxsZDBKdmVEMGlNQ0F3SURRM015NDVNekVnTkRjekxqa3pNU0lnZUcxc09uTndZV05sUFNKd2NtVnpaWEoyWlNJK0lEeGphWEpqYkdVZ2MzUjViR1U5SW1acGJHdzZJMFpHUXpFd1JUc2lJR040UFNJeU16WXVPVFkySWlCamVUMGlNak0yTGprMk5pSWdjajBpTWpNMkxqazJOaUl2UGlBOGNHRjBhQ0J6ZEhsc1pUMGlabWxzYkRvalJrWkdSa1pHT3lJZ1pEMGlUVGd4TGpNNU1Td3lNemN1TVRJell6QXNPRFV1T1RFeExEWTVMalkwT1N3eE5UVXVOVFlzTVRVMUxqVTJMREUxTlM0MU5tTTROUzQ1TVRVc01Dd3hOVFV1TlRZMExUWTVMalkwT1N3eE5UVXVOVFkwTFRFMU5TNDFOaUJNT0RFdU16a3hMREl6Tnk0eE1qTk1PREV1TXpreExESXpOeTR4TWpONklpOCtJRHhuUGlBOGNHRjBhQ0J6ZEhsc1pUMGlabWxzYkRvalEwTkRRa05DT3lJZ1pEMGlUVEUyTnk0M01qZ3NNak0zTGpFeU0yTXdMRFEyTGpRek5Td3dMRGt5TGpnM0xEQXNNVE01TGpNd05tTTJMakF5TkN3ekxqQXdNU3d4TWk0eU56TXNOUzQyTURrc01UZ3VOekE1TERjdU9ESWdZekF0TkRrdU1EUXpMREF0T1RndU1EZ3pMREF0TVRRM0xqRXlOa2d4TmpjdU56STRlaUl2UGlBOGNHRjBhQ0J6ZEhsc1pUMGlabWxzYkRvalEwTkRRa05DT3lJZ1pEMGlUVEk0TXk0ek1Ua3NNak0zTGpFeU0yTXdMRFE1TGpVeE1Td3dMRGs1TGpBeE9Dd3dMREUwT0M0MU1qbGpOaTQwTXpJdE1pNHdNRFlzTVRJdU5qWTJMVFF1TkRVekxERTRMamN3T1MwM0xqSTBJR013TFRRM0xqQTVPQ3d3TFRrMExqRTVNU3d3TFRFME1TNHlPRGxNTWpnekxqTXhPU3d5TXpjdU1USXpUREk0TXk0ek1Ua3NNak0zTGpFeU0zb2lMejRnUEM5blBpQThaejRnUEhCaGRHZ2djM1I1YkdVOUltWnBiR3c2SXpNek16TXpNenNpSUdROUlrMHlNVGt1TVRneExERTFPQzQzT1ROakxURXVOamcwTFRNeExqSTFOUzB5TXk0NU9USXROVE11TlRZdE5UVXVNalF6TFRVMUxqSTBNeUJqTFRNeExqRTROQzB4TGpZNExUVXpMalk1T0N3eU5pNDFNakl0TlRVdU1qUXpMRFUxTGpJME0yTXRNQzQyTlRFc01USXVNRFl6TERFNExqQTJNU3d4TWl3eE9DNDNNRGtzTUdNeUxqVXpOeTAwTnk0d09TdzNNQzQxTXpZdE5EY3VNRGtzTnpNdU1EWTVMREFnUXpJd01TNHhNaXd4TnpBdU56a3pMREl4T1M0NE16SXNNVGN3TGpnMU5pd3lNVGt1TVRneExERTFPQzQzT1ROTU1qRTVMakU0TVN3eE5UZ3VOemt6ZWlJdlBpQThjR0YwYUNCemRIbHNaVDBpWm1sc2JEb2pNek16TXpNek95SWdaRDBpVFRNMU15NDVPRFVzTVRVNExqYzVNMk10TVM0Mk9EUXRNekV1TWpVMUxUSXpMams1TWkwMU15NDFOaTAxTlM0eU5ETXROVFV1TWpReklHTXRNekV1TVRnMExURXVOamd0TlRNdU5qazBMREkyTGpVeU1pMDFOUzR5TkRNc05UVXVNalF6WXkwd0xqWTFNU3d4TWk0d05qTXNNVGd1TURZeExERXlMREU0TGpjd09Td3dZekl1TlRNM0xUUTNMakE1TERjd0xqVXpNaTAwTnk0d09TdzNNeTR3Tmprc01DQkRNek0xTGpreU5Dd3hOekF1TnprekxETTFOQzQyTXpjc01UY3dMamcxTml3ek5UTXVPVGcxTERFMU9DNDNPVE5NTXpVekxqazROU3d4TlRndU56a3plaUl2UGlBOEwyYytJRHd2YzNablBnPT0ifQ==";

    address constant USER = address(1);

    function setUp() public {
        deployer = new DeployMoodNft();
        moodNft = deployer.run();
    }

    function testInitializedCorrectly() public view {
        assert(
            keccak256(abi.encodePacked(moodNft.name())) ==
                keccak256(abi.encodePacked((NFT_NAME)))
        );
        assert(
            keccak256(abi.encodePacked(moodNft.symbol())) ==
                keccak256(abi.encodePacked((NFT_SYMBOL)))
        );
    }

    function testViewTokenURI() public {
        vm.prank(USER);
        moodNft.mintNft();
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        moodNft.mintNft();

        assert(moodNft.balanceOf(USER) == 1);
    }

    function testTokenURIDefaultIsCorrectlySet() public {
        vm.prank(USER);
        moodNft.mintNft();
        assertEq(
            keccak256(abi.encodePacked(moodNft.tokenURI(0))),
            keccak256(abi.encodePacked(HAPPY_SVG_URI))
        );
    }

    function testFlipTokenToHappy() public {
        vm.prank(USER);
        moodNft.mintNft();

        vm.prank(USER);
        moodNft.flipMood(0);

        assertEq(
            keccak256(abi.encodePacked(moodNft.tokenURI(0))),
            keccak256(abi.encodePacked(SAD_SVG_URI))
        );
    }
}
