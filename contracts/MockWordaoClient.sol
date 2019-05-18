pragma solidity 0.5.2;


contract MockWordaoClient {
  mapping (uint => bytes32) public wordMapUncompressed;
  mapping (bytes32 => uint) public wordMapCompressed;

  constructor(bytes32[] memory _words) public {
    for (uint i = 0; i < _words.length; ++i) {
      wordMapUncompressed[i] = _words[i];
      wordMapCompressed[_words[i]] = i;
    }
  }

  function compress(bytes32 _value) public view returns (uint _index) {
    return wordMapCompressed[_value];
  }

  function uncompress(uint _index) public view returns (bytes32 _value) {
    return wordMapUncompressed[_index];
  }
}
