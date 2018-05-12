pragma solidity ^0.4.17;

contract Lottery {
    //setting up the variables
    address public manager;
    address[] public players;
    
    //constructor function
     function Lottery() public {
        manager = msg.sender;
    }
    
    //enter players function
    function enter() public payable {
        require(msg.value > .01 ether);
        players.push(msg.sender);
    }
    
    //psuedo random number function
    function random() private view returns(uint) {
        return uint(keccak256(block.difficulty, now, players));
    }
    
    //pick winner function
    function pickWinner() public restricted {
        uint index = random() % players.length;
        players[index].transfer(address(this).balance);
        players = new address[](0);
    }
    
    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
    
    function getPlayers() public view returns (address[]) {
        return players;
    }
}