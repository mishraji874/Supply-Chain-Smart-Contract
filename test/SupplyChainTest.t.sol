// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {SupplyChain} from "../src/SupplyChain.sol";

contract SupplyChainTest is Test {
    SupplyChain supplyChain;
    address public seller;
    address public buyer;

    function setUp() public {
        supplyChain = new SupplyChain();
        seller = makeAddr("seller");
        buyer = makeAddr("buyer");
    }

    function testCreateOrder() public {
        vm.startPrank(seller);
        supplyChain.createOrder(buyer, 100 ether);
        vm.stopPrank();

        uint256 orderId = supplyChain.orderCount();
        SupplyChain.Order memory order;
        (order.seller, order.buyer, order.price, order.status) = supplyChain.orders(orderId);

        assertEq(order.seller, seller);
        assertEq(order.buyer, buyer);
        assertEq(order.price, 100 ether);
        assertEq(uint(order.status), uint(SupplyChain.Status.Pending));
    }

    function testCreateOrderInvalidBuyer() public {
        vm.prank(seller);
        vm.expectRevert("Invalid buyer address");
        supplyChain.createOrder(address(0), 100 ether);
    }

    function testCreateOrderZeroPrice() public {
        vm.prank(seller);
        vm.expectRevert("Price must be greater than zero");
        supplyChain.createOrder(buyer, 0);
    }

    function testShipOrder() public {
        supplyChain.createOrder(buyer, 100 ether);
        uint256 orderId = supplyChain.orderCount();
        supplyChain.shipOrder(orderId);

        SupplyChain.Order memory order;
        (order.seller, order.buyer, order.price, order.status) = supplyChain.orders(orderId);

        assertEq(uint(order.status), uint(SupplyChain.Status.Shipped));
    }

    function testShipOrderInvalidOrderId() public {
        vm.prank(seller);
        vm.expectRevert("Invalid order ID");
        supplyChain.shipOrder(0);
    }

    function testShipOrderNotSeller() public {
        vm.prank(seller);
        uint256 orderId = supplyChain.orderCount() + 1;
        supplyChain.createOrder(buyer, 100 ether);

        vm.prank(buyer);
        vm.expectRevert("Only seller can ship the order");
        supplyChain.shipOrder(orderId);
    }

    function testDeliverOrder() public {
        supplyChain.createOrder(buyer, 100 ether);
        uint256 orderId = supplyChain.orderCount();
        supplyChain.shipOrder(orderId);

        vm.prank(buyer);
        supplyChain.deliverOrder(orderId);

        SupplyChain.Order memory order;
        (order.seller, order.buyer, order.price, order.status) = supplyChain.orders(orderId);

        assertEq(uint(order.status), uint(SupplyChain.Status.Delivered));
    }

    function testDeliverOrderInvalidOrderId() public {
        vm.prank(buyer);
        vm.expectRevert(bytes("invalid order ID"));
        supplyChain.deliverOrder(0);
    }

    function testDeliverOrderNotBuyer() public {
        supplyChain.createOrder(buyer, 100 ether);

        uint256 orderId = supplyChain.orderCount();
        vm.prank(seller);
        supplyChain.shipOrder(orderId);

        vm.prank(seller);
        vm.expectRevert("Only buyer can confirm delivery");
        supplyChain.deliverOrder(orderId);
    }
}