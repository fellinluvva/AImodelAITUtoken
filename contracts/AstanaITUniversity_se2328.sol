// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AstanaITUniversity_se2328 is ERC20 {
    event TransferDetails(
        address indexed sender,
        address indexed receiver,
        uint256 amount,
        uint256 timestamp
    );

    event ListingCreated(uint256 indexed listingId, address seller, uint256 amount, uint256 price);

    event ListingCancelled(uint256 indexed listingId);

    event ListingPurchased(uint256 indexed listingId, address buyer);

    struct TransferRecord {
        address sender;
        address receiver;
        uint256 amount;
        uint256 timestamp;
    }

    struct Listing {
        address seller;
        uint256 amount;
        uint256 price;
        bool isActive;
    }

    TransferRecord public recentTransfer;
    mapping(uint256 => Listing) public listings;
    uint256 public nextListingId;

    constructor() ERC20("AstanaITUniversity_se2328", "AITU2328") {
        _mint(msg.sender, 2000 * 10**decimals());
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        bool success = super.transfer(recipient, amount);
        if (success) {
            recentTransfer = TransferRecord(msg.sender, recipient, amount, block.timestamp);
            emit TransferDetails(msg.sender, recipient, amount, block.timestamp);
        }
        return success;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        bool success = super.transferFrom(sender, recipient, amount);
        if (success) {
            recentTransfer = TransferRecord(sender, recipient, amount, block.timestamp);
            emit TransferDetails(sender, recipient, amount, block.timestamp);
        }
        return success;
    }

    function getRecentTransfer() public view returns (address, address, uint256, uint256) {
        return (
            recentTransfer.sender,
            recentTransfer.receiver,
            recentTransfer.amount,
            recentTransfer.timestamp
        );
    }

    function getTransferTimestamp() public view returns (uint256) {
        return recentTransfer.timestamp;
    }

    function getTransferSender() public view returns (address) {
        return recentTransfer.sender;
    }

    function getTransferReceiver() public view returns (address) {
        return recentTransfer.receiver;
    }

    function getFormattedTimestamp() public view returns (string memory) {
        return convertTimestampToString(recentTransfer.timestamp);
    }

    function convertTimestampToString(uint256 timestamp) internal view returns (string memory) {
        uint256 SECONDS_IN_DAY = 86400;
        uint256 SECONDS_IN_HOUR = 3600;
        uint256 SECONDS_IN_MINUTE = 60;

        uint16 year = 1970;
        uint8 month;
        uint8 day;

        uint256 daysSinceEpoch = timestamp / SECONDS_IN_DAY;

        while (true) {
            uint256 daysInYear = isLeapYear(year) ? 366 : 365;
            if (daysSinceEpoch < daysInYear) {
                break;
            }
            daysSinceEpoch -= daysInYear;
            year++;
        }

        uint8[12] memory daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        if (isLeapYear(year)) {
            daysInMonth[1] = 29;
        }

        for (month = 0; month < 12; month++) {
            if (daysSinceEpoch < daysInMonth[month]) {
                break;
            }
            daysSinceEpoch -= daysInMonth[month];
        }

        day = uint8(daysSinceEpoch + 1);
        month += 1; // Convert from zero-based index to 1-based month representation

        uint256 remainingSeconds = timestamp % SECONDS_IN_DAY;
        uint8 hour = uint8(remainingSeconds / SECONDS_IN_HOUR);
        uint8 minute = uint8((remainingSeconds % SECONDS_IN_HOUR) / SECONDS_IN_MINUTE);

        return string(
            abi.encodePacked(
                uintToString(day), "/", uintToString(month), "/", uintToString(year),
                " ", uintToString(hour), ":", uintToString(minute)
            )
        );
    }

    function isLeapYear(uint16 year) internal pure returns (bool) {
        if (year % 4 != 0) {
            return false;
        }
        if (year % 100 == 0 && year % 400 != 0) {
            return false;
        }
        return true;
    }

    function uintToString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 length;
        while (temp != 0) {
            length++;
            temp /= 10;
        }
        bytes memory result = new bytes(length);
        uint256 index = length - 1;
        while (value != 0) {
            result[index] = bytes1(uint8(48 + value % 10));
            value /= 10;
            if (index > 0) {
                index--;
            } else {
                break;
            }
        }
        return string(result);
    }


    function createListing(uint256 amount, uint256 price) external returns (uint256) {
        require(amount > 0, "Amount must be greater than 0");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");

        uint256 listingId = nextListingId++;
        listings[listingId] = Listing({
            seller: msg.sender,
            amount: amount,
            price: price,
            isActive: true
        });

        emit ListingCreated(listingId, msg.sender, amount, price);
        return listingId;
    }

    function cancelListing(uint256 listingId) external {
        Listing storage listing = listings[listingId];
        require(listing.isActive, "Listing is not active");
        require(listing.seller == msg.sender, "Only the seller can cancel");

        listing.isActive = false;
        emit ListingCancelled(listingId);
    }

    function purchaseListing(uint256 listingId) external payable {
        Listing storage listing = listings[listingId];
        require(listing.isActive, "Listing is not active");
        require(msg.value >= listing.price, "Insufficient ETH sent");

        listing.isActive = false;

        _transfer(listing.seller, msg.sender, listing.amount);

        payable(listing.seller).transfer(msg.value);

        emit ListingPurchased(listingId, msg.sender);
    }
}