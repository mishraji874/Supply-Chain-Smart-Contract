// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SupplyChain {
    enum Status {
        Pending,
        Shipped,
        Delivered
    }

    struct Order {
        address seller;
        address buyer;
        uint256 price;
        Status status;
    }

    mapping(uint256 => Order) public orders;
    uint256 public orderCount;

    event OrderCreated(
        uint256 orderId,
        address indexed seller,
        address indexed buyer,
        uint256 price
    );

    event OrderShipped(uint256 orderId);
    event OrderDelivered(uint256 orderId);

    function createOrder(address _buyer, uint256 _price) external {
        require(_buyer != address(0), "Invalid buyer address");
        require(_price > 0, "Price must be greater than zero");

        orderCount++;
        orders[orderCount] = Order(msg.sender, _buyer, _price, Status.Pending);
        emit OrderCreated(orderCount, msg.sender, _buyer, _price);
    }

    function shipOrder(uint256 _orderId) external {
        require(_orderId > 0 && _orderId <= orderCount, "Invalid order ID");
        require(msg.sender == orders[_orderId].seller, "Only seller can ship the order");

        orders[_orderId].status = Status.Shipped;
        emit OrderShipped(_orderId);
    }

    function deliverOrder(uint256 _orderId) external {
        require(_orderId > 0 && _orderId <= orderCount, "invalid order ID");
        require(msg.sender == orders[_orderId].buyer, "Only buyer can confirm delivery");

        orders[_orderId].status = Status.Delivered;
        emit OrderDelivered(_orderId);
    }
}