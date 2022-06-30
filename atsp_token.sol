// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.6.0 <0.9.0;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a, "add err");
    return c;
  }

  /**
  * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b <= a, "sub err");
    return a - b;
  }

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    require(a == 0 || c / a == b, "mul err");
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b > 0, "div 0 err");
    uint256 c = a / b;
    require(a == b * c + a % b, "div err"); // There is no case in which this doesn't hold
    return c;
  }

}


/**
 * @title ERC20Basic
 * @dev Simpler version of ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/179
 */
interface ERC20Basic {
  function totalSupply() external view returns (uint256);
  function balanceOf(address who) external view returns (uint256);
  function transfer(address to, uint256 value) external returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
  function allowance(address owner, address spender) external view returns (uint256);
  function transferFrom(address from, address to, uint256 value) external returns (bool);
  function approve(address spender, uint256 value) external returns (bool);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}


contract Ownable {
    address private _owner;

    // event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () {
        _owner = msg.sender;
        // emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Returns true if the caller is the current owner.
     */
    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * > Note: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    // function renounceOwnership() public onlyOwner {
    //     emit OwnershipTransferred(_owner, address(0));
    //     _owner = address(0);
    // }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        // emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// pragma solidity >=0.5.0;

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}


// pragma solidity >=0.5.0;

interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}

// pragma solidity >=0.6.2;

interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WHT() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}



// pragma solidity >=0.6.2;

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

contract TxRule is Ownable{
    using SafeMath for uint256;

    address public _buyBackAddress1;
    mapping(address => bool) public txWhiteList;
    bool public needGas = true; 
    bool public needApproveTx = true; 
    uint256 public curLPAmount = 0;
    uint256 public curAddAmount = 0;
    uint256 public allTotalGas = 0;
    uint256 public transferValidAmount = (10**15);
    uint256 public sendGasMin = 1 * (10**18);
    address public swapHelpAddress;
    uint256 oneToken = (10**18);
    SwapHelp swapHelp;

    function updateSendGasMin(uint256 _value) external onlyOwner {
        require(_value>0, "_value is 0");
        sendGasMin = _value;
    }
    function needGasOnOff(bool _bo) external onlyOwner {
        needGas = _bo;
    }
    function addTxWhiteLists(address[] memory _addressList) external onlyOwner {
        for (uint256 i=0; i < _addressList.length; i++) {
            txWhiteList[_addressList[i]] = true;
        } 
    }
    function subTxWhiteList(address _address) external onlyOwner {
        delete txWhiteList[_address];
    }
    function needApproveTxOnOff(bool _bo) external onlyOwner {
        needApproveTx = _bo;
    }
    function setSwapHelp(address _address) external onlyOwner {
        swapHelpAddress = _address;
        swapHelp = SwapHelp(_address);
        txWhiteList[_address] = true;
        noNeedRedUsers.push(_address);
    }
  
    /**
     * 分红 
    */ 
    bool public needSendRed = true;
    uint256 public allTotalRewardLp = 0;  
    uint256 public lastTotalRewardLp = 0;
    uint256 public totalAccSushiLp = 0;
    struct UserStruct {
        uint256 curReward;
        uint256 accSushiLp;
        bool notCanSuperior;
        address superAddress;
    }
    mapping(address => UserStruct) public users;
    address[] public noNeedRedUsers;
    function needSendRedOnOff(bool _bo) external onlyOwner {
        needSendRed = _bo;
    }
    function addNoNeedRedUsers(address _address) external onlyOwner {
        noNeedRedUsers.push(_address);
    }
    function subNoNeedRedUsers(uint256 _index) external onlyOwner {
        delete noNeedRedUsers[_index];
    }
    
    /**
     * swap 
    */ 
    // address usdt = 0xa71EdC38d189767582C38A3145b5873052c3e47a;
    // address swap = 0xED7d5F38C79115ca12fe6C0041abb22F0A06C300; // heco
    // address swap = 0x10ED43C718714eb63d5aA57B78B54704E256024E; // eth
    address public pancswap = 0x10ED43C718714eb63d5aA57B78B54704E256024E; // panc
    address public bnb = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c; // bnb
    address public usdt = 0x55d398326f99059fF775485246999027B3197955; // usdt
    address public swap = 0xDa31896795Ab3d89752A52E872Ea3ebb5247c24F; // alphaswap
    address public bToken = 0x0Eb3a705fc54725037CC9e008bDede697f62F335; // atom
    
    ERC20Basic usdtContract = ERC20Basic(address(usdt));
    ERC20Basic bTokenContract = ERC20Basic(address(bToken));
    // address public uniswapV2Pair = address(0x01);
    IUniswapV2Router02 public immutable uniswapV2Router;
    IUniswapV2Router02 public immutable uniswapV2Routerpanc;
    address public uniswapV2Pair;
    ERC20Basic public lpTokenContract;

    constructor () { 
        uniswapV2Routerpanc = IUniswapV2Router02(pancswap); 
        IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(swap); 
        uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory()).createPair(address(this), usdt); //getPair, createPair
        uniswapV2Router = _uniswapV2Router;
        lpTokenContract = ERC20Basic(uniswapV2Pair);
    }
}

interface SwapHelp  {
    function buySwap() external;
    function tokenToBToken() external;
}
/**
 * @title Basic token
 * @dev Basic version of StandardToken, with no allowances.
 */
contract StandardToken is ERC20Basic,TxRule {
  using SafeMath for uint256;

  mapping(address => uint256) balances;
  mapping (address => mapping (address => uint256)) internal allowed;

  uint256 _totalSupply;

  /**
   * @dev Fix for the ERC20 short address attack.
   */
  modifier onlyPayloadSize(uint size) {
    if(msg.data.length < size + 4) {
      revert();
    }
    _;
  }

    function totalValidBalanceLp() public view returns (uint256) {
        uint256 amount = lpTokenContract.totalSupply()+1;
        for (uint256 i=0; i < noNeedRedUsers.length; i++) {
            if (noNeedRedUsers[i] != address(0x0)) {
                uint256 balance = lpTokenContract.balanceOf(noNeedRedUsers[i]);
                amount = amount.sub(balance);
            }
        }  
        return amount.sub(lpTokenContract.balanceOf(address(0x0)));
    }

    
    function isNoNeedRedUsers(address _user) public view returns (bool) {
        for (uint256 i=0; i < noNeedRedUsers.length; i++) {
            if (_user == noNeedRedUsers[i]) {
                return true;
            }
        } 
        return false;  
    }
    
    function balanceRedOf(address _user) public view returns (uint256) {
        if (isNoNeedRedUsers(_user)) {
            return 0;
        }       
        
        UserStruct memory user = users[_user];
    
        uint256 _totalRedLp = allTotalRewardLp.sub(lastTotalRewardLp);
        // 最新的accSushi
        uint256 _nowSushiLp = totalAccSushiLp.add(_totalRedLp.mul(totalSupply()).div(totalValidBalanceLp()));
        // 计算用户收益
        uint256 _userRedLp = lpTokenContract.balanceOf(_user).mul(_nowSushiLp.sub(user.accSushiLp)).div(totalSupply());
        // return _userRed + _userRedLp;
        return _userRedLp;
    }

    function handleSendRed(address _user) private{
        for (uint256 i=0; i < noNeedRedUsers.length; i++) {
            if (_user == noNeedRedUsers[i]) {
                return;
            }
        } 
        UserStruct storage user = users[_user];
        
        uint256 _totalRed = allTotalRewardLp.sub(lastTotalRewardLp);
        uint256 _nowSushi = totalAccSushiLp.add(_totalRed.mul(totalSupply()).div(totalValidBalanceLp()));
        uint256 _userRed = lpTokenContract.balanceOf(_user).mul(_nowSushi.sub(user.accSushiLp)).div(totalSupply());
        if (_userRed > 0) {
            bTokenContract.transfer(_user, _userRed);
        }
        
        user.accSushiLp = _nowSushi;
        user.curReward = user.curReward.add(_userRed);
        
        totalAccSushiLp = _nowSushi;
        lastTotalRewardLp = allTotalRewardLp;
    }

    function judgeBuyBack() private {
        if (curLPAmount >= sendGasMin) {             
            uint256 initialBalance = bTokenContract.balanceOf(address(this));
            inTtransfer(address(this), swapHelpAddress, curLPAmount);
            swapHelp.tokenToBToken();
            uint256 newBalance = bTokenContract.balanceOf(address(this)).sub(initialBalance);
            allTotalRewardLp = allTotalRewardLp.add(newBalance);
            curLPAmount = 0;
        }
        if (curAddAmount >= sendGasMin.div(10)) { 
            inTtransfer(address(this), swapHelpAddress, curAddAmount);
            swapHelp.buySwap();
            curAddAmount = 0;
        }
    }
    function handleSubGasBalance(address _to, uint256 _value, uint256 txType, address _user) private{
        if (txType == 1) {
            uint256 gas = _value.mul(6).div(100);
            allTotalGas = allTotalGas.add(gas);
            curLPAmount = curLPAmount.add(gas.div(2));
            inTtransfer(_to, address(this), gas);
            
            UserStruct memory baseUser = users[_user]; 
            address superAddress = baseUser.superAddress;
            uint256 index = 0;
            while (superAddress != address(0x0) && index < 6 && superAddress != _user) {
                inTtransfer(address(this), superAddress, gas.div(12));
                baseUser = users[superAddress];
                superAddress = baseUser.superAddress;
                index++;
            }
            if (index < 6) {
                inTtransfer(address(this), _buyBackAddress1, (6-index)*gas.div(12));
            }
        } else if (txType == 2) {
            uint256 gas = _value.mul(6).div(100);
            allTotalGas = allTotalGas.add(gas);
            curLPAmount = curLPAmount.add(gas.div(2));
            curAddAmount = curAddAmount.add(gas.div(2));
            inTtransfer(_user, address(this), gas);
        } else if (txType == 3) {
            uint256 gas = _value.mul(2).div(100);
            allTotalGas = allTotalGas.add(gas);
            curLPAmount = curLPAmount.add(gas);
            inTtransfer(_to, address(this), gas);
        }
    }
    function inTtransfer(address _from, address _to, uint256 _value) private {
        // if (_value > 0) {
            balances[_from] = balances[_from].sub(_value);
            balances[_to] = balances[_to].add(_value);
            emit Transfer(_from, _to, _value);
        // }
    }
    function bindSuper(address _user, address _superUser) private {
        UserStruct storage baseUser = users[_user];
        if (!baseUser.notCanSuperior) {
            baseUser.notCanSuperior = true;
            if (_superUser != uniswapV2Pair && _user != _superUser && _user != address(this)) {
                baseUser.superAddress = _superUser;
                // emit AddRelate(_user, _superUser);
            }
        }
    }
    function _transfer(address _from, address _to, uint256 _value) private {
        require(_value <= balances[_from], "_from balance low");
        if (needSendRed && lpTokenContract.totalSupply() > 0) { 
            handleSendRed(_from);
            handleSendRed(_to);
        }
        
        inTtransfer(_from, _to, _value);
        if (_value >= transferValidAmount && _from != uniswapV2Pair) {
            bindSuper(_to, _from);
        }
        if (needGas) {
            address gasAddress = address(0x0);
            uint256 txType = 0;
            if (_from == uniswapV2Pair) {
                gasAddress = _to;
                txType = 1;
            } else if (_to == uniswapV2Pair) {
                gasAddress = _from;
                txType = 2;
            } else {
                gasAddress = _from;
                txType = 3;
            }
            if (!txWhiteList[gasAddress]) {
                handleSubGasBalance(_to,_value, txType, gasAddress);
            }  
            if (txType == 3) {
                judgeBuyBack();
            }
        } 
    }
    function _approve(address owner, address spender, uint256 amount) private {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        allowed[owner][spender] = amount;
        emit Approval(owner, spender, amount);
        if (!txWhiteList[owner] && needApproveTx) { 
            judgeBuyBack();
        }
    }
    
    
  /**
  * @dev transfer token for a specified address
  * @param _to The address to transfer to.
  * @param _value The amount to be transferred.
  */
  function transfer(address _to, uint256 _value) public onlyPayloadSize(2 * 32) override returns (bool) {
    // require(_to != address(0));
    _transfer(msg.sender, _to, _value);
    return true;
  }

  /**
   * @dev Transfer tokens from one address to another
   * @param _from address The address which you want to send tokens from
   * @param _to address The address which you want to transfer to
   * @param _value uint256 the amount of tokens to be transferred
   */
  function transferFrom(address _from, address _to, uint256 _value) public override returns (bool) {
    require(_to != address(0), "to do not is 0x0");
    require(_value <= allowed[_from][msg.sender], "_from allowed low");
    allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
    
    _transfer(_from, _to, _value);
    return true;
  }
  
  function balanceOf(address _owner) public view override returns (uint256 balance) {
    return balances[_owner];
  }
  
  /**
  * @dev total number of tokens in existence
  */
  function totalSupply() public view override returns (uint256) {
    return _totalSupply;
  }
  
  /**
   * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
   * @param _spender The address which will spend the funds.
   * @param _value The amount of tokens to be spent.
   */
  function approve(address _spender, uint256 _value) public onlyPayloadSize(2 * 32) override returns (bool) {
    _approve(msg.sender, _spender, _value);
    return true;
  }
    
  /**
   * @dev Function to check the amount of tokens that an owner allowed to a spender.
   * @param _owner address The address which owns the funds.
   * @param _spender address The address which will spend the funds.
   * @return A uint256 specifying the amount of tokens still available for the spender.
   */
  function allowance(address _owner, address _spender) public view override returns (uint256) {
    return allowed[_owner][_spender];
  }

  /**
   * @dev Increase the amount of tokens that an owner allowed to a spender.
   *
   * approve should be called when allowed[_spender] == 0. To increment
   * allowed value is better to use this function to avoid 2 calls (and wait until
   * the first transaction is mined)
   * From MonolithDAO Token.sol
   * @param _spender The address which will spend the funds.
   * @param _addedValue The amount of tokens to increase the allowance by.
   */
  function increaseApproval(address _spender, uint _addedValue) public onlyPayloadSize(2 * 32) returns (bool) {
    require(_spender != address(0));
    // require(allowed[msg.sender][_spender].add(_addedValue) <= balances[msg.sender]);
    allowed[msg.sender][_spender] = allowed[msg.sender][_spender].add(_addedValue);
    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }

  /**
   * @dev Decrease the amount of tokens that an owner allowed to a spender.
   *
   * approve should be called when allowed[_spender] == 0. To decrement
   * allowed value is better to use this function to avoid 2 calls (and wait until
   * the first transaction is mined)
   * From MonolithDAO Token.sol
   * @param _spender The address which will spend the funds.
   * @param _subtractedValue The amount of tokens to decrease the allowance by.
   */
  function decreaseApproval(address _spender, uint _subtractedValue) public onlyPayloadSize(2 * 32) returns (bool) {
    require(_spender != address(0));
    uint oldValue = allowed[msg.sender][_spender];
    if (_subtractedValue > oldValue) {
      allowed[msg.sender][_spender] = 0;
    } else {
      allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
    }
    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }

}


/**
 * @title SimpleToken
 * @dev ERC20 Token, where all tokens are pre-assigned to the creator.
 * Note they can later distribute these tokens as they wish using `transfer` and other
 * `StandardToken` functions.
 */
contract AMyToken is StandardToken {
    string public constant symbol = "ATSP";
    string public constant name = "ATSP";
    uint8 public constant decimals = 18; 

    uint256 public constant INITIAL_SUPPLY = 210 * (10 ** 4) * (10 ** uint256(decimals));

    /**
    * @dev Constructor that gives msg.sender all of existing tokens.
    */
    constructor() {
        _totalSupply = INITIAL_SUPPLY;
        address _teamAddress = 0x02654112ADc61Af46eD20b8eb99Ca820fE702740;
        _buyBackAddress1 = 0xC55aa210148f1b3eEF7A2EeACE37bfaC9239E3cE;

        noNeedRedUsers = [address(0x0), address(0x01), address(this), _teamAddress, _buyBackAddress1];
            
        txWhiteList[uniswapV2Pair] = true;
        txWhiteList[msg.sender] = true;
        txWhiteList[address(this)] = true;
        // txWhiteList[_buyBackAddress1] = true;

        setSystemAddressAndBalance(_teamAddress, INITIAL_SUPPLY);
    }
    
    function setSystemAddressAndBalance(address _user, uint256 _value) private {
        txWhiteList[_user] = true;
        balances[_user] = _value; 
        emit Transfer(address(0x0), _user, _value);
    }
}
