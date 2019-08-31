pragma solidity >=0.4.22 <0.6.0;

contract VotingRoom {

    struct Voter
    {
        uint voterId;
        address payable voterAddr;
    }

    struct Room{
        // count for incermental id for voters 
        uint VotersCount ;
        uint roomId;
        mapping(uint => Voter) votersStructs;
        
    }
    
    // if there's zero rooms 
    bool noRooms = true;

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
        
        noRooms = false;
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
    function addVoter(uint roomId   ) public  returns (uint success) {
        
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
    
    function getVoter(uint roomId , uint voterId ) public view returns (address found) {
        // check if room exists 
        if (room_exist(roomId) == false){
            revert("Room doesnt exists");
        }
        
        // if we got the room right but the voterid wrong 
        
        // if (check_voter(voter) == false){
        //     // soon
        // }
        // get the voter from the room
        return roomsStructs[roomId].votersStructs[voterId].voterAddr;

    }
    
    
    

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