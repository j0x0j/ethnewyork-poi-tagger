/* global artifacts */

const PoiTagger = artifacts.require('./PoiTagger.sol')

module.exports = async function (deployer) {
  await deployer.deploy(PoiTagger, '0x403C88b453BA81c25709e6579c8B5846E9c8344c')
}
