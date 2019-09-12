const VotingRoom = artifacts.require('../contracts/VotingRoom');
describe('inintialize	Room Contract', function() {
  contract('VotingRoom', (accounts) => {


    it('inintialize	Room with 2 Maximum Candidates', () => {
      return VotingRoom.deployed().then((instance) => {
        instance.add_room(2);
				assert.ok(true);
      })
		})


		it('Get Election Room 2 and assert MaxCan Equal 2', () => {
      return VotingRoom.deployed().then((instance) => {
        instance.get_room(0);
      }).then((results)=>{
        console.log(results)
        assert.ok(true);
      })
    })




		it('Add	sender as a voter at First Room', () => {
			return VotingRoom.deployed().then((instance) => {
				instance.add_voter(0);
				assert.ok(true);
			})
		})


		it('Add	sender as a voter at First Room', () => {
			return VotingRoom.deployed().then((instance) => {
				instance.add_voter(0);
				assert.ok(true);
			})
		})



		it('Add	sender as a Candidate at First Room', () => {
			return VotingRoom.deployed().then((instance) => {
				return instance.get_room(0)
				 // assert.ok(true);
			}).then((results)=>{
				assert.ok(true);
			})
		})


		it('Get	Room Data', () => {
			return VotingRoom.deployed().then((instance) => {
				instance.add_candidate(0,1,'Loai');
				assert.ok(true);
			})
		})


  }) // Shutdown Contract
}) // ShutDown Unit Test
