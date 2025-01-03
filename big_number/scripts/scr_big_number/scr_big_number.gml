// v2.3.0에 대한 스크립트 어셋 변경됨 자세한 정보는
// https://help.yoyogames.com/hc/en-us/articles/360005277377 참조
function number(num){
	return new __number__(num);
}

function __number__(num) constructor {
	if(is_real(num)){
		var _num_fract = int64(0);
		var _frac = frac(abs(num));
		num = int64(num);
		self.num_sign = sign(num);
		if(self.num_sign == -1){
			num *= -1;//그냥 abs() 쓰면 타입이 int64가 아니게 되어서 이런식으로 해야함.
		}
		for(var i = 1; i < 30+1; i++){
			if(sign(_frac) == 1 && power(0.5,i) <= _frac){
				_frac -= power(0.5,i);
				_num_fract += 1;
			}
			_num_fract = _num_fract << 1;
		}
		if(_num_fract == 0){
			self.num = [num];
			self.fract_length = 0;
		} else {
			self.num = [_num_fract, num];
			self.fract_length = 1;
		}
	} else {
		self.num = [0];
		self.fract_length = 0;
		var _sign = string_char_at(num,1);
		if(_sign == "+"){
			self.num_sign = 1;
			num = string_copy(num,2,string_length(num)-1);
		} else if(_sign == "-"){
			self.num_sign = -1;
			num = string_copy(num,2,string_length(num)-1);
		} else {
			self.num_sign = 1;
		}
		
		var _dot_pos = string_pos(".",num);
		var _additional_digit = 10 - ((_dot_pos-1) mod 10);
		var _additional_fract = 10 - ((string_length(num) - _dot_pos) mod 10)
		var _pow;
		
		if(_dot_pos != 0){
			num = string_delete(num,_dot_pos,1);
			_pow = (_dot_pos-2) div 10;
			repeat(_additional_digit){
				num = string_insert("0",num,0);
			}
			repeat(_additional_fract){
				num += "0";
			}
		} else {
			_pow = (string_length(num)-1) div 10;
		}
		
		var _pow = (_dot_pos-2) div 10;
		
		for(var i = 0; i < string_length(num); i += 10){
			self.num = __number_sum__(self,__number_multiply__(number(real(string_copy(num,i+1,10))),__number_power__(number(1000000000),number(_pow)))).num;
			//show_message($"[][][]\n{__number_multiply__(number(real(string_copy(num,i+1,10))),__number_power__(number(1000000000),number(_pow)))}\n{number(real(string_copy(num,i+1,10)))}*{__number_power__(number(1000000000),number(_pow))}\n{1000000000}^{_pow}")
			_pow--;
		}
	}
}

function number_string_bin(numb){
	var _str = numb.num_sign == -1 ? "-" : "";
	for(var i = array_length(numb.num)-1; i >= 0; i--){
		if(numb.fract_length-1 == i){
			_str += ".";
		}
		for(var ii = 30; ii >= 0; ii--){
			_str += (numb.num[i] & (1 << ii) != 0) ? "1" : "0";
		}
		_str += "\n";
	}
	
	return _str;
}

function number_string_dec(numb,fract_length = 4){
	var _str = numb.num_sign == -1 ? "-" : "";
	var _digit = 1;
	
	do {
		var _pow1 = __number_power__(number(10),number(_digit));
		var _pow2 = __number_power__(number(10),number(_digit-1));
		var _num = __number_int__(__number_div__(__number_mod__(numb,_pow1),_pow2));
		_str += string_format(_num.num[0],0,0);
		_digit += 1;
	} until (__number_cmp__(numb,__number_power__(number(10),number(_digit))) >= 0)
	
	var _digit = 1;
	for(var i = 0; i < fract_length; i++){
		var _pow = __number_power__(number(10), _digit);
		var _num = __number_int__(__number_mod__(__number_multiply__(numb, _pow),number(10)));
		_str += string_format(_num.num[0],0,0);
		_digit -= 1;
	}
	
	return _str;
}

function number_sum(numb1,numb2){
	if(numb1.num_sign != numb2.num_sign){
		var _cmp = __number_cmp__(numb1,numb2);
		if(_cmp == 1){
			return __number_sub__(numb1,numb2);
		} else if(_cmp == -1){
			return __number_sub__(numb2,numb1);
		}
		return 0;
	}
	return __number_sum__(numb1, numb2);
}

function number_sub(numb1, numb2){
	if(numb1.num_sign != numb2.num_sign){
		return __number_sum__(numb1, numb2);
	}
	return __number_sub__(numb1,numb2);
}

function number_reciprocal(numb1, numb2, accuracy = 1){
	return __number_reciprocal__(numb1, numb2, accuracy);
}

function number_multiply(numb1, numb2, accuracy = 1){
	return __number_multiply__(numb1, numb2, accuracy);
}

function number_div(numb1, numb2, accuracy = 1){
	return __number_div__(numb1, numb2, accuracy);
}

function number_div_int(numb1, numb2){
	return __number_div_int__(numb1, numb2);
}

function number_int(numb){
	return __number_int__(numb);
}

function number_round(numb){
	return __number_round__(numb);
}

function __number_multiply__(numb1,numb2,accuracy){
	numb1 = variable_clone(numb1);
	numb2 = variable_clone(numb2);
	var _result_num = number(0);
	_result_num.num_sign = numb1.num_sign*numb2.num_sign;
	_result_num.num = array_create(array_length(numb1.num)+array_length(numb2.num),0);
	_result_num.fract_length = numb1.fract_length+numb2.fract_length;
	
	for(var i = 0; i < array_length(numb1.num); i++){
		for(var ii = 0; ii < array_length(numb2.num); ii++){
			var _val = numb1.num[i]*numb2.num[ii];
			var _pos = i-numb1.fract_length+ii-numb2.fract_length;
			var _temp_number = number(0);//num_sign은 굳이 지정하지 않음.
			for(var ii = 0; ii < abs(_pos)+1; ii++){
				_temp_number.num[ii] = 0;
			}
			_temp_number.num[_result_num.fract_length+_pos] = _val & 0b0000000000000000000000000000000001111111111111111111111111111111;
			_temp_number.num[_result_num.fract_length+_pos+1] = _val >> 31;
			_temp_number.fract_length = _result_num.fract_length;
			_result_num = __number_sum__(_result_num,_temp_number);
		}
	}
	_result_num = __number_clip__(_result_num,accuracy);
	return _result_num;
}

function __number_power__(numb,pow){
	numb = variable_clone(numb);
	var _result_numb = number(1);
	
	if(pow >= 0){
		for(var i = 0; i < array_length(pow.num)-pow.fract_length; i++){
			if(i > 0){show_error("big number: __number_power__ argument1 is too big?",true);}
			repeat(power(2147483647,i)){
				repeat(pow.num[i]){
					_result_numb = __number_multiply__(_result_numb,numb);
				}
			}
		}
	} else {
		for(var i = 0; i < array_length(pow.num)-pow.fract_length; i++){
			if(i > 0){show_error("big number: __number_power__ argument1 is too big?",true);}
			repeat(power(2147483647,i)){
				repeat(pow.num[i]){
					_result_numb = __number_div__(_result_numb,numb);
				}
			}
		}
	}
	//_result_num = __number_clip__(_result_num); 곱,나눗셈에서 이미 클리핑 됨.
	
	return _result_numb;
}

function __number_div__(numb1,numb2){
	var _result_num = number(0);
	_result_num = __number_multiply__(numb1,__number_reciprocal__(numb2));
	//_result_num = __number_clip__(_result_num); 곱에서 이미 클리핑 됨.
	return _result_num;
}

function __number_div_int__(numb1,numb2){
	var _result_num = number(0);
	_result_num = __number_multiply__(numb1,__number_reciprocal__(numb2));
	//_result_num = __number_clip__(_result_num); 곱에서 이미 클리핑 됨.
	_result_num = __number_int__(_result_num);
	return _result_num;
}

function __number_mod__(numb1, numb2){
	return __number_sub__(numb1,__number_multiply__(__number_int__(__number_div__(numb1,numb2)), numb2));
}

function __number_round__(numb){
	numb = variable_clone(numb);
	
	if(numb.fract_length >= 1){
		var _fract = numb.num[numb.fract_length-1];
		if(_fract & (0b1000000000000000000000000000000)){
			numb = __number_sum__(numb,number(1));
		}
	
		array_delete(numb.num,0,numb.fract_length);
		numb.fract_length = 0;
	}
	return numb;
}

function __number_int__(numb){
	numb = variable_clone(numb);
	array_delete(numb.num,0,numb.fract_length);
	numb.fract_length = 0;
	return numb;
}

function __number_fract__(numb){
	numb = variable_clone(numb);
	var _delete_pos = numb.fract_length+2;
	var _delete_length = array_length(numb.num) - numb.fract_length - 1;
	array_delete(numb.num,_delete_pos,_delete_length);
	numb.fract_length = array_length(numb.num)-1;
	return numb;
}

function __number_reciprocal__(numb, accuracy){
	numb = variable_clone(numb);
	
	if(accuracy != 0){
		if(array_length(numb.num)-numb.fract_length > accuracy){
			return 0;
		}
	}
	
	var _break = false;	
	for(var a = array_length(numb.num)-1; a >= 0; a--){
		for(var b = 30; b >= 0; b--){
			if((numb.num[a] & (1 << b)) != 0){
				_break = true;
				break;
			}
		}
		if(_break){
			break;
		}
	}
	
	if(!_break){
		show_error("big number: can't reciprocal 0!", true);
	}
	
	var _result_num = number(0);
	var _pos_approximation = numb.fract_length*31 - a*31 - b - 1;
	
	if(_pos_approximation >= 0){
		_result_num.fract_length = 0;
		for(var i = 0; i < (abs(_pos_approximation) div 31) + 1; i++){
			_result_num.num[i] = 0;
		}
		_result_num.num[abs(_pos_approximation) div 31] = 1 << (_pos_approximation mod 31);
	} else {
		_result_num.fract_length = (abs(_pos_approximation) div 31) + 1;
		for(var i = 0; i < (abs(_pos_approximation) div 31) + 2; i++){
			_result_num.num[i] = 0;
		}
		_result_num.num[0] = (1 << 31) >> (abs(_pos_approximation) mod 31);
	}
	
	_result_num.num_sign = 1;
	var _numb_2 = number(2);
	
	for(var i = 0; i < 8; i++){
		_result_num = __number_multiply__(_result_num, __number_sub__(_numb_2, __number_multiply__(numb, _result_num, accuracy)), accuracy);
	}
	//나눗셈에 사용될 수 있기 때문에 클리핑 없이 진행
	return _result_num;
}

function __number_sum__(numb1,numb2){
	numb1 = variable_clone(numb1);
	numb2 = variable_clone(numb2);
	
	var _max_fract_length = max(numb1.fract_length, numb2.fract_length);
	numb1.fract_length = _max_fract_length;
	numb2.fract_length = _max_fract_length;
	
	for(var i = array_length(numb1.num)-numb1.fract_length; i < array_length(numb2.num)-numb2.fract_length; i++){
		array_push(numb1.num,0);
	}
	for(var i = array_length(numb2.num)-numb2.fract_length; i < array_length(numb1.num)-numb1.fract_length; i++){
		array_push(numb2.num,0);
	}
	for(var i = numb1.fract_length; i < numb2.fract_length; i++){
		array_insert(numb1.num,0,0);
	}
	for(var i = numb2.fract_length; i < numb1.fract_length; i++){
		array_insert(numb2.num,0,0);
	}
	array_push(numb1.num,0);
	array_push(numb2.num,0);
	
	var _result_num = number(0);
	_result_num.num_sign = numb1.num_sign;
	_result_num.fract_length = numb1.fract_length;
	
	var _overed_value = int64(0);
	for(var i = 0; i < array_length(numb1.num); i++){
		_result_num.num[i] = numb1.num[i]+numb2.num[i]+_overed_value;
		_overed_value = (_result_num.num[i] & 0b1111111111111111111111111111111110000000000000000000000000000000) >> 31;
		_result_num.num[i] = _result_num.num[i] & 0b0000000000000000000000000000000001111111111111111111111111111111;
	}
	
	_result_num = __number_clip__(_result_num);
	
	return _result_num;
}

function __number_sub__(numb1,numb2){
	numb1 = variable_clone(numb1);
	numb2 = variable_clone(numb2);
	
	var _max_fract_length = max(numb1.fract_length, numb2.fract_length);
	numb1.fract_length = _max_fract_length;
	numb2.fract_length = _max_fract_length;
	
	for(var i = array_length(numb1.num)-numb1.fract_length; i < array_length(numb2.num)-numb2.fract_length; i++){
		array_push(numb1.num,0);
	}
	for(var i = array_length(numb2.num)-numb2.fract_length; i < array_length(numb1.num)-numb1.fract_length; i++){
		array_push(numb2.num,0);
	}
	for(var i = numb1.fract_length; i < numb2.fract_length; i++){
		array_insert(numb1.num,0,0);
	}
	for(var i = numb2.fract_length; i < numb1.fract_length; i++){
		array_insert(numb2.num,0,0);
	}
	array_insert(numb1.num,0,0);
	array_insert(numb2.num,0,0);
	numb1.fract_length++;
	numb2.fract_length++;
	
	var _result_num = number(0);
	_result_num.num_sign = numb1.num_sign*__number_cmp__(numb1,numb2);
	_result_num.fract_length = numb1.fract_length;
	
	var _overed_value = int64(0);
	for(var i = 0; i < array_length(numb1.num); i++){
		_result_num.num[i] = numb1.num[i]-numb2.num[i]-_overed_value;
		_overed_value = _result_num.num[i] < 0;
		_result_num.num[i] = _result_num.num[i] & 0b0000000000000000000000000000000001111111111111111111111111111111;
		if(_overed_value){
			_result_num.num[i] *= 1;
		}
	}
	
	_result_num = __number_clip__(_result_num);
	
	return _result_num;
}

function __number_cmp__(numb1,numb2){
	var _balance = array_length(numb1.num)-numb1.fract_length - array_length(numb2.num)-numb2.fract_length;
	
	if(_balance != 0){
		return sign(_balance);
	}
	
	var _numb2_idx = array_length(numb2.num)-1;
	for(var i = array_length(numb1.num)-1; i >= 0; i--){
		if(_numb2_idx < 0){return 1;}
		var _balance = numb1.num[i]-numb2.num[i];
		if(_balance != 0){
			return _balance;
		}
		_numb2_idx--;
	}
	
	return array_length(numb1.num) - array_length(numb2.num);
}

function __number_clip__(numb,fract_length = 0){
	numb = variable_clone(numb);
	for(var i = 0; i < numb.fract_length; i++){
		if(numb.num[i] != 0){
			break;
		}
		array_delete(numb.num,0,1);
		numb.fract_length--;
		i--;
	}
	
	if(fract_length > 0){
		array_delete(numb,0,numb.fract_length-fract_length);
		numb.fract_length -= numb.fract_length-fract_length;
	}
	
	for(var i = array_length(numb.num)-1; i > numb.fract_length; i--){
		if(numb.num[i] != 0){
			break;
		}
		array_pop(numb.num);
	}
	return numb;
}