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

    function new_room() public returns(uint co)
    {
      
        roomsStructs[countRooms].roomId = countRooms;
        allrooms.push(countRooms);
        
        // just to keep it  simple untill we do hash functions 
        countRooms ++ ;
        
        return countRooms;
    }
    
    // checking for the room's existence 
    function room_exist(uint roomId) public view returns (bool exists)  {
        
        // its simple because the id is just incermental 
        // untill we do the hash and more complex logic we will modifi the logic..
        
        if ( roomId > countRooms - 1){
            // Roomid input is larger than the counted rooms 
            return false;
        }
        
        return true;
        
    }
    
    // SOON
    // function addVoter(uint voterId , uint roomId   ) public returns (bool success) {
        
        
        
    // }
    
    
    
    // just testing function
    function test_str(uint id) public view returns (uint x)
    {
        bool checkRoom = room_exist(id);
        if (checkRoom == true) {
         return roomsStructs[id].roomId;   
        }
        else{
            revert("Sorry");
        }
    }
}