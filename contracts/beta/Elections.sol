pragma solidity >=0.4.22 <0.6.0;

contract VotingRoom {



    struct Voter
    {
        // id 
        uint voterId;
        //  account address
        address payable voterAddr;
        
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
        uint VotersCount ;
        uint candidatesCount;
        uint roomId;
        mapping(uint => Voter) votersStructs;

    }
    
    mapping(uint => Candidate) candidateStructs;

    // if there's zero rooms 
    bool noRooms = true;

    mapping(uint => Room) roomsStructs;
    uint[] allrooms;
    
    //  to prevent duplication
    uint countRooms = 0;

// add candidate 

    function add_candidate (uint roomId , string memory candidateName  ) public  returns(bool success){
        
         // check room existence
          if ( room_exist(roomId) == false) {
            revert("the room doesnt exist");
        }
        uint cc = roomsStructs[roomId].candidatesCount;
        
        candidateStructs[cc].candidateId = cc;
        
        candidateStructs[cc].candidateName = candidateName;
        
        roomsStructs[roomId].candidatesCount ++;
        
        return true;
        
    }
    
    
    function get_candidate(uint roomId , uint candidateId) public view returns(string memory  name){
         // check room existence
          if ( room_exist(roomId) == false) {
            revert("the room doesnt exist");
        }
        
       if( candidate_exist(roomId , candidateId)== false ){
           
           revert("candidate is not valid sorry");
       }
     
     uint cc = roomsStructs[roomId].candidatesCount;
        for ( uint i = 0 ; i <= cc ; i++){
            
            if (candidateStructs[i].roomId == roomId){
                return candidateStructs[i].candidateName;
            }
            else{
                return "shit";
            }
        }
        
        
    }
    
    // check candidate_exist
    function candidate_exist( uint roomId,uint candidateId) public view returns (bool exist) {
       
       
         uint cc = roomsStructs[roomId].candidatesCount;
         
         if (cc <= 0 ){
             return false;
         }
        
        if (candidateId > cc -1  )
        {
            return false;
        }
        
        return true;
        

    }
//  Voting

    function vote(uint roomId , uint voterId , uint candidateId) public  returns (bool success){
        
        // check room existence
          if ( room_exist(roomId) == false) {
            revert("the room doesnt exist");
        }
        //check voted existence
        if (voter_exist(roomId,voterId) == false){
            revert("Voter doesnt exist");
        }
        // check if voted before
        if (roomsStructs[roomId].votersStructs[voterId].voted == true){
            revert("Voted Allready has voted before");
        }
        
        // check candidates 
        
         if( candidate_exist(roomId , candidateId)== false ){
           
           revert("candidate is not valid sorry");
       }
     
     
        uint cc = roomsStructs[roomId].candidatesCount;
        for ( uint i = 0 ; i <= cc ; i++){
            
            if (candidateStructs[i].roomId == roomId){
                candidateStructs[candidateId].votesCount++;
                }
           
        }   
           
        // check true 
        roomsStructs[roomId].votersStructs[voterId].voted = true;
        
        // increase votes for the candidate
        
        // roomsStructs[roomId].candidateStructs[candidateId].votes ++;
        
        return false;
    }




    //Create New Voting Channel

    function new_room() public returns(uint co)
    {
      
        roomsStructs[countRooms].roomId = countRooms;
        allrooms.push(countRooms);
        
        // just to keep it  simple untill we do hash functions 
        countRooms ++ ;
        
        noRooms = false;
        return countRooms;
    }
    
    // checking for the room's existence 
    function room_exist(uint roomId) public view returns (bool exists)  {
        
        // its simple because the id is just incermental 
        // untill we do the hash and more complex logic we will modifi the logic..
        
        if (countRooms ==0){
            return false;
        }
        
        
        if ( roomId > countRooms - 1){
            // Roomid input is larger than the counted rooms 
            return false;
        }
        
        return true;
        
    }
    
    // add voter
    function add_voter(uint roomId   ) public  returns (uint success) {
        
        // check if room exists , it will elimnate the program if it false tho .. no worries 
        if (room_exist(roomId) == false){
            revert("Room doesnt exists");
        }
        // add the voter id to the voterarry in the specific room , and
        roomsStructs[roomId].votersStructs[roomId].voterId = roomsStructs[roomId].VotersCount;
        //add adress 
        roomsStructs[roomId].votersStructs[roomId].voterAddr = msg.sender;

        // increase the voters count by 1
        roomsStructs[roomId].VotersCount ++;
        // just for depugging 
        return roomsStructs[roomId].VotersCount;
     }
    
    // get voter address
    function get_voter(uint roomId , uint voterId ) public view returns (address found) {
        // check if room exists 
        if (room_exist(roomId) == false){
            revert("Room doesnt exists");
        }
        
        // if we got the room right but the voterid wrong 
        
        if (voter_exist(roomId , voterId) == false){
            revert("Voter not Valid");
            }
        
        // get the voter from the room
        return roomsStructs[roomId].votersStructs[voterId].voterAddr;

    }
    
    // check voter existence
    function voter_exist (uint roomId , uint voterId) public view returns (bool exists){
        
        // we dont need to check this because we allready did in get_voter
        // if ( room_exist(roomId) == false) {
        //     revert("the room doesnt even exists")
        // }
        
        if (voterId > roomsStructs[roomId].VotersCount - 1){
            return false;
        }
        
        return true;
    }
    

}