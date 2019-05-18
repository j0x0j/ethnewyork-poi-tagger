pragma solidity 0.5.2;

import "./MockWordaoClient.sol";


contract PoiTagger {
  mapping (address => uint[]) public cscTags;

  MockWordaoClient wordaoClient;

  event AddedTag(
    address cscAddress,
    bytes32 tag,
    uint index
  );

  constructor(bytes32[] memory _tags) public {
    // Init anything here
    wordaoClient = new MockWordaoClient(_tags);
  }

  function addTag(address _cscAddress, bytes32 _tag) public returns (bool _tagAdded) {
    uint nextIndex = cscTags[_cscAddress].push(wordaoClient.compress(_tag));
    emit AddedTag(_cscAddress, _tag, nextIndex);

    return true;
  }

  function getTags(address _cscAddress) public view returns (bytes32[] memory _tags) {
    bytes32[] memory tags = new bytes32[](cscTags[_cscAddress].length);

    for (uint i = 0; i < cscTags[_cscAddress].length; ++i) {
      tags[i] = wordaoClient.uncompress(cscTags[_cscAddress][i]);
    }

    return tags;
  }
}
