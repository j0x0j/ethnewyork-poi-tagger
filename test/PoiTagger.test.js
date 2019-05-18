/* global artifacts */
/* global web3 */
/* global contract */
/* global before */
/* global it */
/* global describe */
/* global assert */

const truffleAssert = require('truffle-assertions')

const PoiTagger = artifacts.require('PoiTagger')
const { fromAscii, toUtf8 } = web3.utils

contract('PoiTagger', (accounts) => {
  const _managerAccount = accounts[0]

  let _contract

  before(async function () {
    _contract = await PoiTagger.deployed()
  })

  it('should return an instance of the PoiTagger contract', function () {
    assert.isTrue(typeof _contract !== 'undefined')
  })

  describe('addTag', function () {
    it('should add a tag as its compressed pointer', async () => {
      const tag = 'apple'
      const txn = await _contract.addTag(
        accounts[1],
        fromAscii(tag),
        { from: _managerAccount }
      )
      truffleAssert.eventEmitted(txn, 'AddedTag', (ev) => {
        assert.equal(ev.index, 1)
        return true
      })
    })

    it('should add a second tag as its compressed pointer', async () => {
      const tag = 'blue'
      const txn = await _contract.addTag(
        accounts[1],
        fromAscii(tag),
        { from: _managerAccount }
      )
      truffleAssert.eventEmitted(txn, 'AddedTag', (ev) => {
        assert.equal(ev.index, 2)
        return true
      })
    })
  })

  describe('getTags', function () {
    it('should get a list of tags for a poi address', async () => {
      const tagsHex = await _contract.getTags.call(accounts[1])
      const tags = tagsHex.map(tag => toUtf8(tag))
      assert.equal(tags[0], 'apple')
      assert.equal(tags[1], 'blue')
    })
  })
})
