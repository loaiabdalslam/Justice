pragma solidity >=0.4.22 <0.6.0;
pragma experimental ABIEncoderV2;

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
    
    function vote(uint roomId , address voterAddr , address candidateAddr) public returns (bool voted) {
        
        // check the voter is in the room by comparing the addresses 
        
        
        for (uint i = 0 ; i <= roomsArray[roomId].VotersEntred.length ; i ++ ){
            if ( votersArray[i].voted == true){
                revert("Voter allready voted");
            }
              if (roomsArray[roomId].VotersEntred[i] == voterAddr){
                  
                  for (uint j = 0 ; j <= roomsArray[roomId].maxCan; j ++){
                      
                      if (candidatesArray[j].candidateAddr == candidateAddr){
                          
                          candidatesArray[j].votesCount ++;
                          votersArray[i].voted == true;
                          return true;
                      }
                     
                  }
                     revert("Candidate is not valid in this room");
                }
                else{
                    revert("Voter is not valid in this room");
                }
        }
        return false;
    }
    

    struct Candidate
    {
        // roomId
        uint roomId;
        // id
        address candidateAddr;
        // name
        string candidateName;
        // votes
        uint  votesCount;
    }

// get candidate info
    // function get_candidate (address candidateAddr , uint roomId) public returns(uint roomId , address , string , uint){
        
    // }
  //add candidate

    function add_candidate(uint roomId  , string memory candidateName) public returns(uint){
        // check
        
         
        Room storage room = roomsArray[roomId];
        
        if (room.candidates[msg.sender].candidateAddr == msg.sender ){
            revert ("EROOORRRR");
        }
        if (room.candidatesCount <= roomsArray[roomId].maxCan - 1 ){
            room.candidates[msg.sender] = Candidate(roomId,msg.sender,candidateName , 0);
            candidatesArray.push(Candidate(roomId , msg.sender , candidateName , 0 ));
            room.candidatesEntred.push(msg.sender);
            room.candidatesCount++;
        }
        else{
            revert("Sorry , Its Full Room");
        }


    }


    struct Room{
        // count for incermental id for voters
        uint roomId;
        uint VotersCount ;
        
        // candidatesEntred
        address [] candidatesEntred;
        address [] VotersEntred;
        uint maxCan;
        mapping (address => Candidate)  candidates;
        uint candidatesCount;

    }
    Voter[]  public votersArray;
    Candidate[] public candidatesArray;
    Room[]   roomsArray;
    uint roomsCount;

//get room 

   function get_room (uint roomId) public view returns (uint , uint , address[] memory , address[] memory, uint , uint){
       Room memory room = roomsArray[roomId];
       return (room.roomId , room.VotersCount , room.candidatesEntred , room.VotersEntred,room.maxCan,room.candidatesCount);
    }

    
    

    //! Solved : Bug at add_room fucntion !  (Copying of type struct VotingRoom.Candidate memory[] memory to storage not yet supported.)
    function add_room (uint maxCan) public {

        address[] memory voters ;
        address[] memory candidates;
        roomsArray.push(Room(roomsCount,0,candidates,voters,maxCan,0));
        
        roomsCount++;
    }
// 
    function test (uint roomId) public view returns (Candidate memory ca) {
        Room storage room = roomsArray[roomId];
        
        return room.candidates[msg.sender];
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
        roomsArray[roomId].VotersCount++;
    }

 
}
