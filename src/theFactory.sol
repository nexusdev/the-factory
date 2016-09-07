import "dapple/test.sol";

contract TheFactory {
  mapping (bytes32 => bytes) code;

  function storeCode(bytes _code) returns (bytes32 _hash){
    _hash = sha3(_code);
    code[_hash] = _code;
  }

  function deploy(bytes32 _id) returns (address ret) {
    bytes memory _code = code[_id];
    assembly {
      let len := mload(_code)
      ret := create(0, add(_code, 32), mload(_code))
    }
  }
}

contract TheFactoryTest is Test {

  TheFactory factory;
  bytes code = "\x60\x14\x80\x60\x0b\x60\x00\x39\x60\x00\xf3\x36\x80\x60\x00\x60\x00\x37\x60\x00\x60\x00\xf0\x60\x00\x52\x60\x20\x60\x00\xf3";
  function testTheFactory() {
    factory = new TheFactory();
    bytes32 _id = factory.storeCode(code);
    address addr = factory.deploy(_id);
    //@log `address addr`
  }

}
