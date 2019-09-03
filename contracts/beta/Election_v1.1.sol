pragma solidity >=0.4.22 <0.6.0;

contract VotingRoom {



    struct Voter
    {
        // id 
        uint voterId;
        //  account address
        address payable voterAddr;
        
        // roomsEntred contains id's of rooms
        uint[] roomsEntred;
        
        // voted or not
        // solidity will assigin voted to false as default .. perfectly :) [0 is the default value in struct]
        bool voted;
        
    }
    
    struct Candidate 
    {
        // id
        uint candidateId;
        // name
        string candidateName;
        // votes 
        uint  votesCount;
        // roomId
        uint roomId;
    }

    struct Room{
        // count for incermental id for voters 
        uint roomId;
        uint VotersCount ;
        uint candidatesCount;
        
        address[] VotersEntred;
        
    }
    
    Room[]  roomsArray;
    uint roomsCount;
    // NEW LOGIC 
    // New Room
    function add_room () public {
        
        address[] memory voters ;
        roomsArray.push(Room(roomsCount,0,0 , voters));
        roomsCount++;
    }
    
    function add_voter(uint roomId) public {
        roomsArray[roomId].VotersEntred.push( msg.sender);
    }
    
    function get_room (uint roomId) public view returns (uint id , uint VotersCount ,
                                                        uint candidatesCount ,
                                                        address[] memory VotersEntred){
        Room memory room = roomsArray[roomId];
        return (room.roomId , room.VotersCount, room.candidatesCount,room.VotersEntred
        );
    }
  
}