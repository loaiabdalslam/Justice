const Election = artifacts.require('../contracts/Election');

contract('Election',(accounts)=>{

	it('inintialize	with two candinate',()=>{
		return Election.deployed().then((instance)=>{
			return instance.CandidatesCount();
		}).then((count)=>{
			assert.equal(count,2)

		})
	})

})