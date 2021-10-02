// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Chadliness is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    // Mapping from token ID to chadhood
    mapping(uint256 => string) private _proofsOfChadliness;
    bytes internal constant PIXEL_CHAD =
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -0.5 24 24" shape-rendering="crispEdges"><path stroke="#009688" d="M0 0h1M18 0h2M1 1h2M4 1h1M19 1h1M5 2h1M7 2h1M20 2h2M4 3h1M19 3h1M21 3h2M0 4h1M5 4h1M21 4h1M23 4h1M0 5h2M19 5h1M22 5h1M4 6h1M6 6h1M19 6h2M1 7h1M4 7h2M7 7h1M22 7h1M0 8h1M6 8h1M22 8h1M1 9h1M3 9h1M5 9h1M7 9h1M19 9h1M22 9h1M1 10h1M7 10h1M21 10h1M23 10h1M5 11h1M19 11h1M22 11h1M1 12h2M4 12h2M20 12h1M23 12h1M0 13h1M2 13h2M19 13h1M22 13h1M1 14h1M3 14h1M20 14h2M0 15h1M4 15h1M19 15h1M1 16h1M18 16h1M20 16h1M22 16h1M2 17h3M19 17h1M22 17h1M4 18h2M19 18h1M21 18h1M3 19h1M6 19h2M4 20h1M1 21h1M0 23h1" /><path stroke="#009788" d="M1 0h1M4 0h1M22 0h1M22 1h1M1 2h1M4 2h1M19 2h1M22 2h1M1 3h1M7 3h1M1 4h1M4 4h1M7 4h1M19 4h1M22 4h1M4 5h1M7 5h1M1 6h1M7 6h1M22 6h1M19 7h1M1 8h1M4 8h1M7 8h1M19 8h1M4 9h1M4 10h1M19 10h1M22 10h1M1 11h1M4 11h1M19 12h1M22 12h1M1 13h1M4 13h1M4 14h1M19 14h1M22 14h1M1 15h1M22 15h1M4 16h1M7 16h1M19 16h1M1 17h1M7 17h1M10 17h1M1 18h1M7 18h1M10 18h1M22 18h1M1 19h1M4 19h1M1 20h1" /><path stroke="#009689" d="M2 0h1M5 0h2M21 0h1M23 0h1M0 1h1M20 1h1M23 1h1M0 2h1M0 3h1M2 3h2M5 3h2M20 3h1M23 3h1M3 4h1M2 5h2M23 5h1M5 6h1M2 7h1M20 7h2M5 8h1M0 9h1M6 9h1M21 9h1M23 9h1M6 10h1M0 11h1M2 11h1M23 11h1M21 13h1M2 14h1M2 15h2M23 15h1M0 16h1M5 16h1M6 17h1M2 18h2M6 18h1M9 18h1M18 18h1M20 18h1M0 21h1M0 22h1" /><path stroke="#019689" d="M3 0h1M6 1h1M2 2h2M8 2h1M2 4h1M6 5h1M20 5h1M0 6h1M23 6h1M0 7h1M2 8h2M20 8h2M2 10h1M20 10h1M3 11h1M21 11h1M5 13h1M0 14h1M5 14h1M21 15h1M2 16h1M6 16h1M5 17h1M20 17h1M23 17h1M23 18h1M0 19h1M2 20h1M5 20h1" /><path stroke="#000000" d="M7 0h2M16 0h2M7 1h4M15 1h1M18 6h1M18 8h1M8 9h1M10 9h1M13 9h1M18 9h1M9 10h1M11 10h1M16 10h1M16 11h1M6 12h2M13 12h1M15 12h2M16 13h2M7 14h3M13 14h1M15 14h1M18 14h1M6 15h2M11 15h1M16 15h2M10 16h1M14 16h1M11 22h1" /><path stroke="#010000" d="M9 0h1M15 0h1M12 1h1M14 1h1M18 5h1M18 7h1M11 9h1M17 9h1M14 10h1M17 10h2M15 11h1M18 11h1M9 12h1M14 12h1M17 12h2M11 13h1M6 14h1M8 15h2M15 15h1M9 16h1M12 16h1M12 21h1M12 22h1" /><path stroke="#000100" d="M10 0h1M13 0h1M13 1h1M16 1h1M16 2h1M16 3h1M16 9h1M7 11h1M7 13h1M10 13h1M13 13h1M10 14h1M16 14h1M10 15h1M13 15h1M13 16h1M16 16h1" /><path stroke="#010001" d="M11 0h1M17 1h1M15 2h1M17 2h2M17 3h1M18 4h1M17 8h1M12 10h2M15 10h1M8 11h1M9 13h1M12 13h1M14 13h2M18 13h1M11 14h2M14 14h1M17 14h1M8 16h1M11 16h1M17 16h1" /><path stroke="#000001" d="M12 0h1M14 0h1M11 1h1M14 2h1M18 3h1M17 7h1M9 9h1M12 9h1M8 10h1M17 11h1M8 12h1M6 13h1M8 13h1M12 15h1M14 15h1M18 15h1M15 16h1M11 23h1" /><path stroke="#019688" d="M20 0h1M3 1h1M5 1h1M18 1h1M21 1h1M6 2h1M23 2h1M8 3h1M6 4h1M20 4h1M5 5h1M21 5h1M2 6h2M21 6h1M3 7h1M6 7h1M23 7h1M23 8h1M2 9h1M20 9h1M0 10h1M3 10h1M5 10h1M6 11h1M20 11h1M0 12h1M3 12h1M21 12h1M20 13h1M23 13h1M23 14h1M5 15h1M20 15h1M3 16h1M21 16h1M23 16h1M0 17h1M8 17h2M18 17h1M21 17h1M0 18h1M8 18h1M2 19h1M5 19h1M0 20h1M3 20h1" /><path stroke="#80d8ff" d="M9 2h2M12 3h2M15 3h1M11 4h1M8 5h1M11 5h3M17 5h1M9 6h1M11 6h1M13 6h1M15 6h3M10 7h2M16 7h1M8 8h1M13 8h2M12 17h1M15 17h1M14 18h2M9 19h1M15 19h1M6 20h1M11 20h1M14 20h1M17 20h1M8 21h2M11 21h1M15 21h1M18 21h1M20 21h1M23 21h1M14 22h2M23 22h1M12 23h1M15 23h1M20 23h1" /><path stroke="#80d8fe" d="M11 2h1M11 3h1M14 5h1M14 9h1M8 19h1M12 19h1M21 19h1M23 19h1M18 20h1M23 20h1M3 21h1M21 21h1M2 22h2M6 22h1M8 22h1M17 22h1M5 23h2M8 23h2M21 23h1" /><path stroke="#81d8ff" d="M12 2h1M9 3h1M14 3h1M12 4h1M14 4h1M17 4h1M12 6h1M14 6h1M8 7h2M14 7h1M15 8h1M15 9h1M13 17h2M16 17h1M11 18h1M17 18h1M11 19h1M14 19h1M16 19h1M18 19h1M7 20h4M13 20h1M19 20h3M7 21h1M10 21h1M13 21h1M19 21h1M5 22h1M7 22h1M9 22h1M20 22h1M2 23h1M13 23h1M17 23h1M22 23h1" /><path stroke="#80d9ff" d="M13 2h1M10 3h1M13 4h1M10 6h1M13 7h1M10 8h1M16 8h1" /><path stroke="#81d8fe" d="M8 4h1M8 6h1M15 7h1M9 8h1M11 17h1M17 17h1M12 18h1M17 19h1M20 19h1M12 20h1M15 20h1M2 21h1M5 21h2M14 21h1M17 21h1M18 22h1M21 22h1M3 23h1M14 23h1M18 23h1M23 23h1" /><path stroke="#02a9f4" d="M9 4h1M15 4h1" /><path stroke="#03a8f4" d="M10 4h1" /><path stroke="#03a9f4" d="M16 4h1" /><path stroke="#0c47a1" d="M9 5h1" /><path stroke="#82b1ff" d="M10 5h1M11 8h2" /><path stroke="#0d47a0" d="M15 5h1" /><path stroke="#82b0ff" d="M16 5h1" /><path stroke="#82b1fe" d="M12 7h1" /><path stroke="#010101" d="M10 10h1" /><path stroke="#fefffe" d="M9 11h1" /><path stroke="#fffeff" d="M10 11h1M13 11h1M10 12h1" /><path stroke="#feffff" d="M11 11h2M14 11h1M11 12h2" /><path stroke="#81d9ff" d="M13 18h1M16 18h1M10 19h1M13 19h1M19 19h1M22 19h1M16 20h1M22 20h1M4 21h1M16 21h1M22 21h1M1 22h1M4 22h1M10 22h1M13 22h1M16 22h1M19 22h1M22 22h1M1 23h1M4 23h1M7 23h1M10 23h1M16 23h1M19 23h1" /></svg>';
    bytes internal constant BASE64_PIXEL_CHAD =
        "PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgLTAuNSAyNCAyNCIgc2hhcGUtcmVuZGVyaW5nPSJjcmlzcEVkZ2VzIj48bWV0YWRhdGE+TWFkZSB3aXRoIFBpeGVscyB0byBTdmcgaHR0cHM6Ly9jb2RlcGVuLmlvL3Noc2hhdy9wZW4vWGJ4dk5qPC9tZXRhZGF0YT48cGF0aCBzdHJva2U9IiMwMDk2ODgiIGQ9Ik0wIDBoMU0xOCAwaDJNMSAxaDJNNCAxaDFNMTkgMWgxTTUgMmgxTTcgMmgxTTIwIDJoMk00IDNoMU0xOSAzaDFNMjEgM2gyTTAgNGgxTTUgNGgxTTIxIDRoMU0yMyA0aDFNMCA1aDJNMTkgNWgxTTIyIDVoMU00IDZoMU02IDZoMU0xOSA2aDJNMSA3aDFNNCA3aDJNNyA3aDFNMjIgN2gxTTAgOGgxTTYgOGgxTTIyIDhoMU0xIDloMU0zIDloMU01IDloMU03IDloMU0xOSA5aDFNMjIgOWgxTTEgMTBoMU03IDEwaDFNMjEgMTBoMU0yMyAxMGgxTTUgMTFoMU0xOSAxMWgxTTIyIDExaDFNMSAxMmgyTTQgMTJoMk0yMCAxMmgxTTIzIDEyaDFNMCAxM2gxTTIgMTNoMk0xOSAxM2gxTTIyIDEzaDFNMSAxNGgxTTMgMTRoMU0yMCAxNGgyTTAgMTVoMU00IDE1aDFNMTkgMTVoMU0xIDE2aDFNMTggMTZoMU0yMCAxNmgxTTIyIDE2aDFNMiAxN2gzTTE5IDE3aDFNMjIgMTdoMU00IDE4aDJNMTkgMThoMU0yMSAxOGgxTTMgMTloMU02IDE5aDJNNCAyMGgxTTEgMjFoMU0wIDIzaDEiIC8+PHBhdGggc3Ryb2tlPSIjMDA5Nzg4IiBkPSJNMSAwaDFNNCAwaDFNMjIgMGgxTTIyIDFoMU0xIDJoMU00IDJoMU0xOSAyaDFNMjIgMmgxTTEgM2gxTTcgM2gxTTEgNGgxTTQgNGgxTTcgNGgxTTE5IDRoMU0yMiA0aDFNNCA1aDFNNyA1aDFNMSA2aDFNNyA2aDFNMjIgNmgxTTE5IDdoMU0xIDhoMU00IDhoMU03IDhoMU0xOSA4aDFNNCA5aDFNNCAxMGgxTTE5IDEwaDFNMjIgMTBoMU0xIDExaDFNNCAxMWgxTTE5IDEyaDFNMjIgMTJoMU0xIDEzaDFNNCAxM2gxTTQgMTRoMU0xOSAxNGgxTTIyIDE0aDFNMSAxNWgxTTIyIDE1aDFNNCAxNmgxTTcgMTZoMU0xOSAxNmgxTTEgMTdoMU03IDE3aDFNMTAgMTdoMU0xIDE4aDFNNyAxOGgxTTEwIDE4aDFNMjIgMThoMU0xIDE5aDFNNCAxOWgxTTEgMjBoMSIgLz48cGF0aCBzdHJva2U9IiMwMDk2ODkiIGQ9Ik0yIDBoMU01IDBoMk0yMSAwaDFNMjMgMGgxTTAgMWgxTTIwIDFoMU0yMyAxaDFNMCAyaDFNMCAzaDFNMiAzaDJNNSAzaDJNMjAgM2gxTTIzIDNoMU0zIDRoMU0yIDVoMk0yMyA1aDFNNSA2aDFNMiA3aDFNMjAgN2gyTTUgOGgxTTAgOWgxTTYgOWgxTTIxIDloMU0yMyA5aDFNNiAxMGgxTTAgMTFoMU0yIDExaDFNMjMgMTFoMU0yMSAxM2gxTTIgMTRoMU0yIDE1aDJNMjMgMTVoMU0wIDE2aDFNNSAxNmgxTTYgMTdoMU0yIDE4aDJNNiAxOGgxTTkgMThoMU0xOCAxOGgxTTIwIDE4aDFNMCAyMWgxTTAgMjJoMSIgLz48cGF0aCBzdHJva2U9IiMwMTk2ODkiIGQ9Ik0zIDBoMU02IDFoMU0yIDJoMk04IDJoMU0yIDRoMU02IDVoMU0yMCA1aDFNMCA2aDFNMjMgNmgxTTAgN2gxTTIgOGgyTTIwIDhoMk0yIDEwaDFNMjAgMTBoMU0zIDExaDFNMjEgMTFoMU01IDEzaDFNMCAxNGgxTTUgMTRoMU0yMSAxNWgxTTIgMTZoMU02IDE2aDFNNSAxN2gxTTIwIDE3aDFNMjMgMTdoMU0yMyAxOGgxTTAgMTloMU0yIDIwaDFNNSAyMGgxIiAvPjxwYXRoIHN0cm9rZT0iIzAwMDAwMCIgZD0iTTcgMGgyTTE2IDBoMk03IDFoNE0xNSAxaDFNMTggNmgxTTE4IDhoMU04IDloMU0xMCA5aDFNMTMgOWgxTTE4IDloMU05IDEwaDFNMTEgMTBoMU0xNiAxMGgxTTE2IDExaDFNNiAxMmgyTTEzIDEyaDFNMTUgMTJoMk0xNiAxM2gyTTcgMTRoM00xMyAxNGgxTTE1IDE0aDFNMTggMTRoMU02IDE1aDJNMTEgMTVoMU0xNiAxNWgyTTEwIDE2aDFNMTQgMTZoMU0xMSAyMmgxIiAvPjxwYXRoIHN0cm9rZT0iIzAxMDAwMCIgZD0iTTkgMGgxTTE1IDBoMU0xMiAxaDFNMTQgMWgxTTE4IDVoMU0xOCA3aDFNMTEgOWgxTTE3IDloMU0xNCAxMGgxTTE3IDEwaDJNMTUgMTFoMU0xOCAxMWgxTTkgMTJoMU0xNCAxMmgxTTE3IDEyaDJNMTEgMTNoMU02IDE0aDFNOCAxNWgyTTE1IDE1aDFNOSAxNmgxTTEyIDE2aDFNMTIgMjFoMU0xMiAyMmgxIiAvPjxwYXRoIHN0cm9rZT0iIzAwMDEwMCIgZD0iTTEwIDBoMU0xMyAwaDFNMTMgMWgxTTE2IDFoMU0xNiAyaDFNMTYgM2gxTTE2IDloMU03IDExaDFNNyAxM2gxTTEwIDEzaDFNMTMgMTNoMU0xMCAxNGgxTTE2IDE0aDFNMTAgMTVoMU0xMyAxNWgxTTEzIDE2aDFNMTYgMTZoMSIgLz48cGF0aCBzdHJva2U9IiMwMTAwMDEiIGQ9Ik0xMSAwaDFNMTcgMWgxTTE1IDJoMU0xNyAyaDJNMTcgM2gxTTE4IDRoMU0xNyA4aDFNMTIgMTBoMk0xNSAxMGgxTTggMTFoMU05IDEzaDFNMTIgMTNoMU0xNCAxM2gyTTE4IDEzaDFNMTEgMTRoMk0xNCAxNGgxTTE3IDE0aDFNOCAxNmgxTTExIDE2aDFNMTcgMTZoMSIgLz48cGF0aCBzdHJva2U9IiMwMDAwMDEiIGQ9Ik0xMiAwaDFNMTQgMGgxTTExIDFoMU0xNCAyaDFNMTggM2gxTTE3IDdoMU05IDloMU0xMiA5aDFNOCAxMGgxTTE3IDExaDFNOCAxMmgxTTYgMTNoMU04IDEzaDFNMTIgMTVoMU0xNCAxNWgxTTE4IDE1aDFNMTUgMTZoMU0xMSAyM2gxIiAvPjxwYXRoIHN0cm9rZT0iIzAxOTY4OCIgZD0iTTIwIDBoMU0zIDFoMU01IDFoMU0xOCAxaDFNMjEgMWgxTTYgMmgxTTIzIDJoMU04IDNoMU02IDRoMU0yMCA0aDFNNSA1aDFNMjEgNWgxTTIgNmgyTTIxIDZoMU0zIDdoMU02IDdoMU0yMyA3aDFNMjMgOGgxTTIgOWgxTTIwIDloMU0wIDEwaDFNMyAxMGgxTTUgMTBoMU02IDExaDFNMjAgMTFoMU0wIDEyaDFNMyAxMmgxTTIxIDEyaDFNMjAgMTNoMU0yMyAxM2gxTTIzIDE0aDFNNSAxNWgxTTIwIDE1aDFNMyAxNmgxTTIxIDE2aDFNMjMgMTZoMU0wIDE3aDFNOCAxN2gyTTE4IDE3aDFNMjEgMTdoMU0wIDE4aDFNOCAxOGgxTTIgMTloMU01IDE5aDFNMCAyMGgxTTMgMjBoMSIgLz48cGF0aCBzdHJva2U9IiM4MGQ4ZmYiIGQ9Ik05IDJoMk0xMiAzaDJNMTUgM2gxTTExIDRoMU04IDVoMU0xMSA1aDNNMTcgNWgxTTkgNmgxTTExIDZoMU0xMyA2aDFNMTUgNmgzTTEwIDdoMk0xNiA3aDFNOCA4aDFNMTMgOGgyTTEyIDE3aDFNMTUgMTdoMU0xNCAxOGgyTTkgMTloMU0xNSAxOWgxTTYgMjBoMU0xMSAyMGgxTTE0IDIwaDFNMTcgMjBoMU04IDIxaDJNMTEgMjFoMU0xNSAyMWgxTTE4IDIxaDFNMjAgMjFoMU0yMyAyMWgxTTE0IDIyaDJNMjMgMjJoMU0xMiAyM2gxTTE1IDIzaDFNMjAgMjNoMSIgLz48cGF0aCBzdHJva2U9IiM4MGQ4ZmUiIGQ9Ik0xMSAyaDFNMTEgM2gxTTE0IDVoMU0xNCA5aDFNOCAxOWgxTTEyIDE5aDFNMjEgMTloMU0yMyAxOWgxTTE4IDIwaDFNMjMgMjBoMU0zIDIxaDFNMjEgMjFoMU0yIDIyaDJNNiAyMmgxTTggMjJoMU0xNyAyMmgxTTUgMjNoMk04IDIzaDJNMjEgMjNoMSIgLz48cGF0aCBzdHJva2U9IiM4MWQ4ZmYiIGQ9Ik0xMiAyaDFNOSAzaDFNMTQgM2gxTTEyIDRoMU0xNCA0aDFNMTcgNGgxTTEyIDZoMU0xNCA2aDFNOCA3aDJNMTQgN2gxTTE1IDhoMU0xNSA5aDFNMTMgMTdoMk0xNiAxN2gxTTExIDE4aDFNMTcgMThoMU0xMSAxOWgxTTE0IDE5aDFNMTYgMTloMU0xOCAxOWgxTTcgMjBoNE0xMyAyMGgxTTE5IDIwaDNNNyAyMWgxTTEwIDIxaDFNMTMgMjFoMU0xOSAyMWgxTTUgMjJoMU03IDIyaDFNOSAyMmgxTTIwIDIyaDFNMiAyM2gxTTEzIDIzaDFNMTcgMjNoMU0yMiAyM2gxIiAvPjxwYXRoIHN0cm9rZT0iIzgwZDlmZiIgZD0iTTEzIDJoMU0xMCAzaDFNMTMgNGgxTTEwIDZoMU0xMyA3aDFNMTAgOGgxTTE2IDhoMSIgLz48cGF0aCBzdHJva2U9IiM4MWQ4ZmUiIGQ9Ik04IDRoMU04IDZoMU0xNSA3aDFNOSA4aDFNMTEgMTdoMU0xNyAxN2gxTTEyIDE4aDFNMTcgMTloMU0yMCAxOWgxTTEyIDIwaDFNMTUgMjBoMU0yIDIxaDFNNSAyMWgyTTE0IDIxaDFNMTcgMjFoMU0xOCAyMmgxTTIxIDIyaDFNMyAyM2gxTTE0IDIzaDFNMTggMjNoMU0yMyAyM2gxIiAvPjxwYXRoIHN0cm9rZT0iIzAyYTlmNCIgZD0iTTkgNGgxTTE1IDRoMSIgLz48cGF0aCBzdHJva2U9IiMwM2E4ZjQiIGQ9Ik0xMCA0aDEiIC8+PHBhdGggc3Ryb2tlPSIjMDNhOWY0IiBkPSJNMTYgNGgxIiAvPjxwYXRoIHN0cm9rZT0iIzBjNDdhMSIgZD0iTTkgNWgxIiAvPjxwYXRoIHN0cm9rZT0iIzgyYjFmZiIgZD0iTTEwIDVoMU0xMSA4aDIiIC8+PHBhdGggc3Ryb2tlPSIjMGQ0N2EwIiBkPSJNMTUgNWgxIiAvPjxwYXRoIHN0cm9rZT0iIzgyYjBmZiIgZD0iTTE2IDVoMSIgLz48cGF0aCBzdHJva2U9IiM4MmIxZmUiIGQ9Ik0xMiA3aDEiIC8+PHBhdGggc3Ryb2tlPSIjMDEwMTAxIiBkPSJNMTAgMTBoMSIgLz48cGF0aCBzdHJva2U9IiNmZWZmZmUiIGQ9Ik05IDExaDEiIC8+PHBhdGggc3Ryb2tlPSIjZmZmZWZmIiBkPSJNMTAgMTFoMU0xMyAxMWgxTTEwIDEyaDEiIC8+PHBhdGggc3Ryb2tlPSIjZmVmZmZmIiBkPSJNMTEgMTFoMk0xNCAxMWgxTTExIDEyaDIiIC8+PHBhdGggc3Ryb2tlPSIjODFkOWZmIiBkPSJNMTMgMThoMU0xNiAxOGgxTTEwIDE5aDFNMTMgMTloMU0xOSAxOWgxTTIyIDE5aDFNMTYgMjBoMU0yMiAyMGgxTTQgMjFoMU0xNiAyMWgxTTIyIDIxaDFNMSAyMmgxTTQgMjJoMU0xMCAyMmgxTTEzIDIyaDFNMTYgMjJoMU0xOSAyMmgxTTIyIDIyaDFNMSAyM2gxTTQgMjNoMU03IDIzaDFNMTAgMjNoMU0xNiAyM2gxTTE5IDIzaDEiIC8+PC9zdmc+";

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
                    "data:text/plain,",
                    string(
                        abi.encodePacked(
                            '{"name":"',
                            name(),
                            '", "proofOfChadliness":"',
                            _proofsOfChadliness[tokenId],
                            '", "image":"data:image/svg+xml:base64,',
                            BASE64_PIXEL_CHAD,
                            '"}'
                        )
                    )
                )
            );
    }
}