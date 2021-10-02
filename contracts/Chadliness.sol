// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Base64.sol";

contract Chadliness is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    // Mapping from token ID to chadhood
    mapping(uint256 => string) private _proofsOfChadliness;
    bytes internal constant BASE64_PIXEL_CHAD =
        "PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgLTAuNSAyNCAyNCIgc2hhcGUtcmVuZGVyaW5nPSJjcmlzcEVkZ2VzIj48bWV0YWRhdGE+TWFkZSB3aXRoIFBpeGVscyB0byBTdmcgaHR0cHM6Ly9jb2RlcGVuLmlvL3Noc2hhdy9wZW4vWGJ4dk5qPC9tZXRhZGF0YT48cGF0aCBzdHJva2U9IiMwMDk2ODgiIGQ9Ik0wIDBoMU0xOCAwaDJNMSAxaDJNNCAxaDFNMTkgMWgxTTUgMmgxTTcgMmgxTTIwIDJoMk00IDNoMU0xOSAzaDFNMjEgM2gyTTAgNGgxTTUgNGgxTTIxIDRoMU0yMyA0aDFNMCA1aDJNMTkgNWgxTTIyIDVoMU00IDZoMU02IDZoMU0xOSA2aDJNMSA3aDFNNCA3aDJNNyA3aDFNMjIgN2gxTTAgOGgxTTYgOGgxTTIyIDhoMU0xIDloMU0zIDloMU01IDloMU03IDloMU0xOSA5aDFNMjIgOWgxTTEgMTBoMU03IDEwaDFNMjEgMTBoMU0yMyAxMGgxTTUgMTFoMU0xOSAxMWgxTTIyIDExaDFNMSAxMmgyTTQgMTJoMk0yMCAxMmgxTTIzIDEyaDFNMCAxM2gxTTIgMTNoMk0xOSAxM2gxTTIyIDEzaDFNMSAxNGgxTTMgMTRoMU0yMCAxNGgyTTAgMTVoMU00IDE1aDFNMTkgMTVoMU0xIDE2aDFNMTggMTZoMU0yMCAxNmgxTTIyIDE2aDFNMiAxN2gzTTE5IDE3aDFNMjIgMTdoMU00IDE4aDJNMTkgMThoMU0yMSAxOGgxTTMgMTloMU02IDE5aDJNNCAyMGgxTTEgMjFoMU0wIDIzaDEiIC8+PHBhdGggc3Ryb2tlPSIjMDA5Nzg4IiBkPSJNMSAwaDFNNCAwaDFNMjIgMGgxTTIyIDFoMU0xIDJoMU00IDJoMU0xOSAyaDFNMjIgMmgxTTEgM2gxTTcgM2gxTTEgNGgxTTQgNGgxTTcgNGgxTTE5IDRoMU0yMiA0aDFNNCA1aDFNNyA1aDFNMSA2aDFNNyA2aDFNMjIgNmgxTTE5IDdoMU0xIDhoMU00IDhoMU03IDhoMU0xOSA4aDFNNCA5aDFNNCAxMGgxTTE5IDEwaDFNMjIgMTBoMU0xIDExaDFNNCAxMWgxTTE5IDEyaDFNMjIgMTJoMU0xIDEzaDFNNCAxM2gxTTQgMTRoMU0xOSAxNGgxTTIyIDE0aDFNMSAxNWgxTTIyIDE1aDFNNCAxNmgxTTcgMTZoMU0xOSAxNmgxTTEgMTdoMU03IDE3aDFNMTAgMTdoMU0xIDE4aDFNNyAxOGgxTTEwIDE4aDFNMjIgMThoMU0xIDE5aDFNNCAxOWgxTTEgMjBoMSIgLz48cGF0aCBzdHJva2U9IiMwMDk2ODkiIGQ9Ik0yIDBoMU01IDBoMk0yMSAwaDFNMjMgMGgxTTAgMWgxTTIwIDFoMU0yMyAxaDFNMCAyaDFNMCAzaDFNMiAzaDJNNSAzaDJNMjAgM2gxTTIzIDNoMU0zIDRoMU0yIDVoMk0yMyA1aDFNNSA2aDFNMiA3aDFNMjAgN2gyTTUgOGgxTTAgOWgxTTYgOWgxTTIxIDloMU0yMyA5aDFNNiAxMGgxTTAgMTFoMU0yIDExaDFNMjMgMTFoMU0yMSAxM2gxTTIgMTRoMU0yIDE1aDJNMjMgMTVoMU0wIDE2aDFNNSAxNmgxTTYgMTdoMU0yIDE4aDJNNiAxOGgxTTkgMThoMU0xOCAxOGgxTTIwIDE4aDFNMCAyMWgxTTAgMjJoMSIgLz48cGF0aCBzdHJva2U9IiMwMTk2ODkiIGQ9Ik0zIDBoMU02IDFoMU0yIDJoMk04IDJoMU0yIDRoMU02IDVoMU0yMCA1aDFNMCA2aDFNMjMgNmgxTTAgN2gxTTIgOGgyTTIwIDhoMk0yIDEwaDFNMjAgMTBoMU0zIDExaDFNMjEgMTFoMU01IDEzaDFNMCAxNGgxTTUgMTRoMU0yMSAxNWgxTTIgMTZoMU02IDE2aDFNNSAxN2gxTTIwIDE3aDFNMjMgMTdoMU0yMyAxOGgxTTAgMTloMU0yIDIwaDFNNSAyMGgxIiAvPjxwYXRoIHN0cm9rZT0iIzAwMDAwMCIgZD0iTTcgMGgyTTE2IDBoMk03IDFoNE0xNSAxaDFNMTggNmgxTTE4IDhoMU04IDloMU0xMCA5aDFNMTMgOWgxTTE4IDloMU05IDEwaDFNMTEgMTBoMU0xNiAxMGgxTTE2IDExaDFNNiAxMmgyTTEzIDEyaDFNMTUgMTJoMk0xNiAxM2gyTTcgMTRoM00xMyAxNGgxTTE1IDE0aDFNMTggMTRoMU02IDE1aDJNMTEgMTVoMU0xNiAxNWgyTTEwIDE2aDFNMTQgMTZoMU0xMSAyMmgxIiAvPjxwYXRoIHN0cm9rZT0iIzAxMDAwMCIgZD0iTTkgMGgxTTE1IDBoMU0xMiAxaDFNMTQgMWgxTTE4IDVoMU0xOCA3aDFNMTEgOWgxTTE3IDloMU0xNCAxMGgxTTE3IDEwaDJNMTUgMTFoMU0xOCAxMWgxTTkgMTJoMU0xNCAxMmgxTTE3IDEyaDJNMTEgMTNoMU02IDE0aDFNOCAxNWgyTTE1IDE1aDFNOSAxNmgxTTEyIDE2aDFNMTIgMjFoMU0xMiAyMmgxIiAvPjxwYXRoIHN0cm9rZT0iIzAwMDEwMCIgZD0iTTEwIDBoMU0xMyAwaDFNMTMgMWgxTTE2IDFoMU0xNiAyaDFNMTYgM2gxTTE2IDloMU03IDExaDFNNyAxM2gxTTEwIDEzaDFNMTMgMTNoMU0xMCAxNGgxTTE2IDE0aDFNMTAgMTVoMU0xMyAxNWgxTTEzIDE2aDFNMTYgMTZoMSIgLz48cGF0aCBzdHJva2U9IiMwMTAwMDEiIGQ9Ik0xMSAwaDFNMTcgMWgxTTE1IDJoMU0xNyAyaDJNMTcgM2gxTTE4IDRoMU0xNyA4aDFNMTIgMTBoMk0xNSAxMGgxTTggMTFoMU05IDEzaDFNMTIgMTNoMU0xNCAxM2gyTTE4IDEzaDFNMTEgMTRoMk0xNCAxNGgxTTE3IDE0aDFNOCAxNmgxTTExIDE2aDFNMTcgMTZoMSIgLz48cGF0aCBzdHJva2U9IiMwMDAwMDEiIGQ9Ik0xMiAwaDFNMTQgMGgxTTExIDFoMU0xNCAyaDFNMTggM2gxTTE3IDdoMU05IDloMU0xMiA5aDFNOCAxMGgxTTE3IDExaDFNOCAxMmgxTTYgMTNoMU04IDEzaDFNMTIgMTVoMU0xNCAxNWgxTTE4IDE1aDFNMTUgMTZoMU0xMSAyM2gxIiAvPjxwYXRoIHN0cm9rZT0iIzAxOTY4OCIgZD0iTTIwIDBoMU0zIDFoMU01IDFoMU0xOCAxaDFNMjEgMWgxTTYgMmgxTTIzIDJoMU04IDNoMU02IDRoMU0yMCA0aDFNNSA1aDFNMjEgNWgxTTIgNmgyTTIxIDZoMU0zIDdoMU02IDdoMU0yMyA3aDFNMjMgOGgxTTIgOWgxTTIwIDloMU0wIDEwaDFNMyAxMGgxTTUgMTBoMU02IDExaDFNMjAgMTFoMU0wIDEyaDFNMyAxMmgxTTIxIDEyaDFNMjAgMTNoMU0yMyAxM2gxTTIzIDE0aDFNNSAxNWgxTTIwIDE1aDFNMyAxNmgxTTIxIDE2aDFNMjMgMTZoMU0wIDE3aDFNOCAxN2gyTTE4IDE3aDFNMjEgMTdoMU0wIDE4aDFNOCAxOGgxTTIgMTloMU01IDE5aDFNMCAyMGgxTTMgMjBoMSIgLz48cGF0aCBzdHJva2U9IiM4MGQ4ZmYiIGQ9Ik05IDJoMk0xMiAzaDJNMTUgM2gxTTExIDRoMU04IDVoMU0xMSA1aDNNMTcgNWgxTTkgNmgxTTExIDZoMU0xMyA2aDFNMTUgNmgzTTEwIDdoMk0xNiA3aDFNOCA4aDFNMTMgOGgyTTEyIDE3aDFNMTUgMTdoMU0xNCAxOGgyTTkgMTloMU0xNSAxOWgxTTYgMjBoMU0xMSAyMGgxTTE0IDIwaDFNMTcgMjBoMU04IDIxaDJNMTEgMjFoMU0xNSAyMWgxTTE4IDIxaDFNMjAgMjFoMU0yMyAyMWgxTTE0IDIyaDJNMjMgMjJoMU0xMiAyM2gxTTE1IDIzaDFNMjAgMjNoMSIgLz48cGF0aCBzdHJva2U9IiM4MGQ4ZmUiIGQ9Ik0xMSAyaDFNMTEgM2gxTTE0IDVoMU0xNCA5aDFNOCAxOWgxTTEyIDE5aDFNMjEgMTloMU0yMyAxOWgxTTE4IDIwaDFNMjMgMjBoMU0zIDIxaDFNMjEgMjFoMU0yIDIyaDJNNiAyMmgxTTggMjJoMU0xNyAyMmgxTTUgMjNoMk04IDIzaDJNMjEgMjNoMSIgLz48cGF0aCBzdHJva2U9IiM4MWQ4ZmYiIGQ9Ik0xMiAyaDFNOSAzaDFNMTQgM2gxTTEyIDRoMU0xNCA0aDFNMTcgNGgxTTEyIDZoMU0xNCA2aDFNOCA3aDJNMTQgN2gxTTE1IDhoMU0xNSA5aDFNMTMgMTdoMk0xNiAxN2gxTTExIDE4aDFNMTcgMThoMU0xMSAxOWgxTTE0IDE5aDFNMTYgMTloMU0xOCAxOWgxTTcgMjBoNE0xMyAyMGgxTTE5IDIwaDNNNyAyMWgxTTEwIDIxaDFNMTMgMjFoMU0xOSAyMWgxTTUgMjJoMU03IDIyaDFNOSAyMmgxTTIwIDIyaDFNMiAyM2gxTTEzIDIzaDFNMTcgMjNoMU0yMiAyM2gxIiAvPjxwYXRoIHN0cm9rZT0iIzgwZDlmZiIgZD0iTTEzIDJoMU0xMCAzaDFNMTMgNGgxTTEwIDZoMU0xMyA3aDFNMTAgOGgxTTE2IDhoMSIgLz48cGF0aCBzdHJva2U9IiM4MWQ4ZmUiIGQ9Ik04IDRoMU04IDZoMU0xNSA3aDFNOSA4aDFNMTEgMTdoMU0xNyAxN2gxTTEyIDE4aDFNMTcgMTloMU0yMCAxOWgxTTEyIDIwaDFNMTUgMjBoMU0yIDIxaDFNNSAyMWgyTTE0IDIxaDFNMTcgMjFoMU0xOCAyMmgxTTIxIDIyaDFNMyAyM2gxTTE0IDIzaDFNMTggMjNoMU0yMyAyM2gxIiAvPjxwYXRoIHN0cm9rZT0iIzAyYTlmNCIgZD0iTTkgNGgxTTE1IDRoMSIgLz48cGF0aCBzdHJva2U9IiMwM2E4ZjQiIGQ9Ik0xMCA0aDEiIC8+PHBhdGggc3Ryb2tlPSIjMDNhOWY0IiBkPSJNMTYgNGgxIiAvPjxwYXRoIHN0cm9rZT0iIzBjNDdhMSIgZD0iTTkgNWgxIiAvPjxwYXRoIHN0cm9rZT0iIzgyYjFmZiIgZD0iTTEwIDVoMU0xMSA4aDIiIC8+PHBhdGggc3Ryb2tlPSIjMGQ0N2EwIiBkPSJNMTUgNWgxIiAvPjxwYXRoIHN0cm9rZT0iIzgyYjBmZiIgZD0iTTE2IDVoMSIgLz48cGF0aCBzdHJva2U9IiM4MmIxZmUiIGQ9Ik0xMiA3aDEiIC8+PHBhdGggc3Ryb2tlPSIjMDEwMTAxIiBkPSJNMTAgMTBoMSIgLz48cGF0aCBzdHJva2U9IiNmZWZmZmUiIGQ9Ik05IDExaDEiIC8+PHBhdGggc3Ryb2tlPSIjZmZmZWZmIiBkPSJNMTAgMTFoMU0xMyAxMWgxTTEwIDEyaDEiIC8+PHBhdGggc3Ryb2tlPSIjZmVmZmZmIiBkPSJNMTEgMTFoMk0xNCAxMWgxTTExIDEyaDIiIC8+PHBhdGggc3Ryb2tlPSIjODFkOWZmIiBkPSJNMTMgMThoMU0xNiAxOGgxTTEwIDE5aDFNMTMgMTloMU0xOSAxOWgxTTIyIDE5aDFNMTYgMjBoMU0yMiAyMGgxTTQgMjFoMU0xNiAyMWgxTTIyIDIxaDFNMSAyMmgxTTQgMjJoMU0xMCAyMmgxTTEzIDIyaDFNMTYgMjJoMU0xOSAyMmgxTTIyIDIyaDFNMSAyM2gxTTQgMjNoMU03IDIzaDFNMTAgMjNoMU0xNiAyM2gxTTE5IDIzaDEiIC8+PC9zdmc+Cg==";

    constructor()
        ERC721("Why yes, I did return the COMP. How could you tell ? ", "AGC")
    {}

    function mint(address receiver, string memory proofOfChadliness)
        external
        onlyOwner
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(receiver, newItemId);
        _proofsOfChadliness[newItemId] = proofOfChadliness;

        return newItemId;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(),
                                '", "proofOfChadliness":"',
                                _proofsOfChadliness[tokenId],
                                '", "image":"data:image/svg+xml;base64,',
                                BASE64_PIXEL_CHAD,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
