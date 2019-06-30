pragma solidity ^0.5.8;

contract Election {


	struct voter {
		address id;
		string nationalId;
		string votingKey;
		string votingPass;
		bool vote;
	}

	struct candidate {
		uint id;
		string name;
		uint voteCount;
	}

	mapping( uint => candidate) public candidates;
	mapping( address => voter) public voters;

	uint public votersCount;
	uint public candidatesCount;

	event votedEvent(
		uint indexed _canidateId
	);



	constructor() public {

		addCandidates('Loai abdalslam');
		addCandidates('Mohamed abdalslam');
		addCandidates('Mohamed Ahmed');
		addCandidates('Mohamed Salam');

/*
		addVoters({from:'0xE2Eb60Dc54935Ae625cd58FEf42821795da09353'},'xxxx1','xxxx1','$$$$1');
		addVoters({from:'0x360B6740D7778bbA82F1D81B5eeAEacF71C023A5'},'xxxx2','xxxx2','$$$$2');
*/
	}

	function addCandidates(string memory _name) private {

	candidatesCount++;

	candidates[candidatesCount] = candidate(candidatesCount,_name,0);

	}

	function addVoters(string memory  _nationalId,string memory _votingKey,string memory _votingPass) private {
	votersCount++;
	bool vote = false;

	voters[msg.sender] = voter(msg.sender,_nationalId,_votingKey,_votingPass,vote);

	}


	function vote(string memory  _nationalId,string memory _votingKey,string memory _votingPass,uint _canidateId) public {
		addVoters(_nationalId,_votingKey,_votingPass);

		require(voters[msg.sender].id == msg.sender);
		require(voters[msg.sender].vote != true);	
		require(_canidateId > 0 && _canidateId <= candidatesCount);

		voters[msg.sender].vote = true;

		candidates[_canidateId].voteCount ++;

		emit votedEvent(_canidateId);
	}



}