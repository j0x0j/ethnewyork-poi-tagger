pragma solidity 0.5.2;

import "../../ETHNY-Word-Dao/contracts/Manager.sol";


contract PoiTagger {
  mapping (address => uint32[]) public cscTags;
  mapping (address => bytes32[]) public cscTagsUncompressed;

  Manager wordDaoClient;

  event AddedTag(
    address cscAddress,
    bytes32 tag,
    uint256 index
  );

  constructor(address _managerAddress) public {
    // Init anything here
    wordDaoClient = Manager(_managerAddress);
  }

  function addTag(address _cscAddress, bytes32 _tag) public returns (bool _tagAdded) {
    uint256 nextIndex = cscTags[_cscAddress].push(wordDaoClient.getIndex(_tag));
    emit AddedTag(_cscAddress, _tag, nextIndex);

    return true;
  }

  function addTagUncompressed(address _cscAddress, bytes32 _tag) public returns (bool _tagAdded) {
    uint256 nextIndex = cscTagsUncompressed[_cscAddress].push(_tag);
    emit AddedTag(_cscAddress, _tag, nextIndex);

    return true;
  }

  function getTags(address _cscAddress) public view returns (bytes32[] memory _tags) {
    bytes32[] memory tags = new bytes32[](cscTags[_cscAddress].length);

    for (uint32 i = 0; i < cscTags[_cscAddress].length; ++i) {
      tags[i] = wordDaoClient.getBytesByKey(cscTags[_cscAddress][i]);
    }

    return tags;
  }

  function getTagsUncompressed(address _cscAddress) public view returns (bytes32[] memory _tags) {
    bytes32[] memory tags = new bytes32[](cscTagsUncompressed[_cscAddress].length);

    for (uint32 i = 0; i < cscTagsUncompressed[_cscAddress].length; ++i) {
      tags[i] = cscTagsUncompressed[_cscAddress][i];
    }

    return tags;
  }
}
