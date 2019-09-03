pragma solidity >=0.4.22 <0.6.0;
contract VotingRoom {



    struct Voter
    {
       
        address payable voterAddr;
        
        // roomsEntred contains id's of rooms
        uint[] roomsEntred;
        
        // voted or not
        // solidity will assigin voted to false as default .. perfectly :) [0 is the default value in struct]
        bool voted;
        
    }
    
    struct Candidate 
    {
        // roomId
        uint roomId;
        // id
        uint candidateId;
        // name
        string candidateName;
        // votes 
        uint  votesCount;
    }

  //add candidate 
    
    function add_candidate(uint roomId , uint candidateId , string memory candidateName) public returns(uint){
        // check 
        if (roomsArray[roomId].candidatesCount <= roomsArray[roomId].maxCan){
            

            roomsArray[roomId].candidatesCount++;
        }
        
        
    }
    

    struct Room{
        // count for incermental id for voters 
        uint roomId;
        uint VotersCount ;
        Candidate [] candidates;
        address [] VotersEntred;
        uint maxCan;
        uint candidatesCount;
        
    }
    Voter[]  votersArray;
    Room[]   roomsArray;
    uint roomsCount;
    // NEW LOGIC 
    // New Room
    function add_room (uint maxCan) public {
        
        address[] memory voters ;
        Candidate[] memory candidates;
        roomsArray.push(Room(roomsCount,0,candidates , voters ,maxCan , 0));
        roomsCount++;
    }
    
    
    // add voter 
    function 
    add_voter(uint roomId )
    public {
        // this we can use to support multible rooms for each voter somehow.
        uint[] memory roomsEntred;
        
        // Make instance of voter to push it to votersArray
        Voter memory voter =  Voter(msg.sender,roomsEntred , false) ;
        
        votersArray.push(voter);
        roomsArray[roomId].VotersEntred.push( msg.sender);
    }
    
    function
    get_room (uint roomId)public view returns (uint id , uint VotersCount ,
    Candidate[] memory candidates ,address[] memory VotersEntred , uint maxCan , uint candidatesCount){
        Room memory room = roomsArray[roomId];
        return (room.roomId , room.VotersCount, room.candidates,room.VotersEntred , room.maxCan , room.candidatesCount);
        
        
    }
    
   
  
}