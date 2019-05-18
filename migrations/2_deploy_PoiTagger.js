/* global artifacts */
/* global web3 */

const PoiTagger = artifacts.require('./PoiTagger.sol')

module.exports = async function (deployer) {
  await deployer.deploy(PoiTagger, [
    web3.utils.toHex('apple'),
    web3.utils.toHex('blue'),
    web3.utils.toHex('camel'),
    web3.utils.toHex('dart')
  ])
}
