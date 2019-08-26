pragma solidity >=0.4.22 <0.6.0;

contract VotingRoom {

    struct Voter
    {
        uint PlayerId;
        address payable userAddr;
    }


    struct Room{
        uint[] VotersCount;
        uint roomList;
        mapping(uint => Voter) votersStructs;
        Voter player;
    }

    mapping(uint => Room) roomsStructs;
    uint[] allrooms;


    //Create New Voting Channel

    function newRoom(uint roomnumber) public returns(bool success)
    {
        //To check Channel is created or not!
        for(uint i =1; i <=roomnumber; i++){
            require(roomsStructs[roomnumber].roomList != i );
        }
        roomsStructs[roomnumber].roomList = roomnumber;
        allrooms.push(roomnumber);
        return true;
    }


    //Get Channel Details
    function getRoom(uint roomnumber) public view returns(uint votersCounts)
    {
        //To check Channel is created or not!
        uint roomNum = roomsStructs[roomnumber].roomList;
        if(roomNum != 0){
            return(roomsStructs[roomnumber].VotersCount.length);
        }
        else{
            revert("Room is not created!!");
        }
    }




    //To Add Voter in Channel
    function addVoter(uint roomnumber,uint roomId,uint maxVoterCount) public returns(bool message)
    {
        //To check Channel is created or not!
        uint roomNum = roomsStructs[roomnumber].roomList;
        if(roomNum != 0){
            uint voterCounter = roomsStructs[roomnumber].VotersCount.length;
            if(voterCounter < maxVoterCount){
                roomsStructs[roomnumber].VotersCount.push(roomId);
                roomsStructs[roomnumber].votersStructs[roomId].userAddr = msg.sender;
                roomsStructs[roomnumber].votersStructs[roomId].PlayerId = roomId;
                return true;
            }
            else{
                revert("Enter in new Channel, its full!!");
            }
        }
        else{
            revert("Channel is not created!!");
        }
    }




}
