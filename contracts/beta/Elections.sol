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
        address [] candidatesEntred;
        address [] VotersEntred;
        uint maxCan;
        uint candidatesCount;

    }
    Voter[]  votersArray;
    Candidate [] candidatesArray;
    Room[]   roomsArray;
    uint roomsCount;


    //! Solved : Bug at add_room fucntion !  (Copying of type struct VotingRoom.Candidate memory[] memory to storage not yet supported.)
    function add_room (uint maxCan) public {

        address[] memory voters ;
        address[] memory candidates;
        roomsArray.push(Room(roomsCount,0,candidates,voters,maxCan,0));

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

    function get_room (uint roomId) public view returns (Room memory){
       return roomsArray[roomId];



    }



}
