// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Test {
    // 存放罗马数字转整数map
    mapping(bytes1 => uint) public romanToIntMap;

    constructor() {
        romanToIntMap["I"] = 1; // 0x49
        romanToIntMap["V"] = 5; // 0x56
        romanToIntMap["X"] = 10; // 0x58
        romanToIntMap["L"] = 50; // 0x4c
        romanToIntMap["C"] = 100; // 0x43
        romanToIntMap["D"] = 500; // 0x44
        romanToIntMap["M"] = 1000; // 0x4d
    }

    // 反转字符串
    function reverseString(
        string memory str
    ) public pure returns (string memory) {
        bytes memory bytesStr = bytes(str);
        for (uint i = 0; i <= bytesStr.length / 2; i++) {
            bytesStr[i] = bytesStr[bytesStr.length - i - 1];
        }
        return string(bytesStr);
    }

    // 整数转罗马数字
    function intToRoman(uint number) public pure returns (string memory) {
        string memory result;
        uint divideFirst = number / 1000;
        for (uint i = 0; i <= divideFirst; i++) {
            result = string.concat(result, "M");
        }

        uint divideSecond = (number - divideFirst * 1000) / 100;
        result = string.concat(
            result,
            intToRomanItem(divideSecond, "C", "D", "M")
        );

        uint divideThird = (number - divideFirst * 1000 - divideSecond * 100) /
            10;
        result = string.concat(
            result,
            intToRomanItem(divideThird, "X", "L", "C")
        );

        uint divideFour = number -
            divideFirst *
            1000 -
            divideSecond *
            100 -
            divideThird *
            10;
        result = string.concat(
            result,
            intToRomanItem(divideFour, "I", "V", "X")
        );

        return result;
    }

    function intToRomanItem(
        uint divide,
        string memory str1,
        string memory str2,
        string memory str3
    ) private pure returns (string memory) {
        string memory str;
        if (divide >= 1 && divide <= 3) {
            for (uint i = 0; i <= divide; i++) {
                str = string.concat(str, str1);
            }
            return str;
        }

        if (divide == 4) {
            return string.concat(str1, str2);
        }

        if (divide == 5) {
            return str2;
        }

        if (divide >= 6 && divide <= 8) {
            str = str2;
            for (uint i = 0; i <= divide - 5; i++) {
                str = string.concat(str, str1);
            }
            return str;
        }

        if (divide == 9) {
            return string.concat(str1, str3);
        }

        return str;
    }

    // 罗马数字转整数
    function romanToInt(string memory s) public view returns (uint) {
        uint result;
        bytes memory strBytes = bytes(s);
        for (uint i = 0; i < strBytes.length; i++) {
            bytes1 item = strBytes[i];
            result += romanToIntMap[item];
            // 满足条件会减去两倍
            if (i < strBytes.length - 1) {
                if (
                    item == 0x49 &&
                    (strBytes[i + 1] == 0x56 || strBytes[i + 1] == 0x58)
                ) {
                    result -= romanToIntMap[item] * 2;
                } else if (
                    item == 0x58 &&
                    (strBytes[i + 1] == 0x4c || strBytes[i + 1] == 0x43)
                ) {
                    result -= romanToIntMap[item] * 2;
                } else if (
                    item == 0x43 &&
                    (strBytes[i + 1] == 0x44 || strBytes[i + 1] == 0x4d)
                ) {
                    result -= romanToIntMap[item] * 2;
                }
            }
        }
        return result;
    }

    // 合并两个有序数组
    function mergeSortedArray(
        uint256[] memory arr1,
        uint256[] memory arr2
    ) public pure returns (uint256[] memory) {
        uint256[] memory resultArr;
        uint256 resultIndex;
        uint256 arr2Index;

        for (uint i = 0; i < arr1.length; i++) {
            for (uint j = arr2Index; j < arr2.length; j++) {
                if (arr1[i] >= arr2[j]) {
                    resultArr[resultIndex] = arr2[j];
                    arr2Index++;
                } else {
                    resultArr[resultIndex] = arr1[i];
                    break;
                }
                resultIndex++;
            }
        }

        if (arr2Index + 1 < arr2.length) {
            for (uint256 j = arr2Index; j < arr2.length; j++) {
                resultArr[resultIndex] = (arr2[j]);
            }
        }
        return resultArr;
    }

    // 二分查找
    function binarySearch(
        uint256[] memory arr,
        uint256 target
    ) public pure returns (uint256) {
        uint256 left = 0;
        uint256 right = arr.length - 1;

        while (left <= right) {
            uint256 mid = left + (right - left) / 2;
            if (arr[mid] == target) {
                return mid;
            } else if (target > arr[mid]) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        // 未找到
        return 0;
    }
}
