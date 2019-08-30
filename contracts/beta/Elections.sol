pragma solidity >=0.4.22 <0.6.0;

contract VotingRoom {

    struct Voter
    {
        uint VoterId;
        address payable userAddr;
    }


    struct Room{
        uint[] VotersCount;
        uint roomId;
        mapping(uint => Voter) votersStructs;
        Voter player;
    }

    mapping(uint => Room) roomsStructs;
    uint[] allrooms;
    
    //  to prevent duplication
    uint countRooms = 0;

    //Create New Voting Channel

    function newRoom() public returns(bool success)
    {
      
        roomsStructs[countRooms].roomId = countRooms;
        allrooms.push(countRooms);
        
        // just to keep it  simple untill we do hash functions 
        countRooms ++ ;
        
        return true;
    }
    
    function test_str(uint id) public view returns (uint x)
    {
     return roomsStructs[id].roomId;   
    }
}