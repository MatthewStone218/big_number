// v2.3.0에 대한 스크립트 어셋 변경됨 자세한 정보는
// https://help.yoyogames.com/hc/en-us/articles/360005277377 참조
function number(num){
	return new __number__(num);
}

function __number__(num){
	if(is_real(num)){
		num = int64(num);
		self.num_sign = sign(num);
		if(self.num_sign == -1){
			num *= -1;//그냥 abs() 쓰면 타입이 int64가 아니게 되어서 이런식으로 해야함.
		}
		var _num_fract = int64(0);
		var _frac = frac(abs(num));
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
		if(_dot_pos != 0){
			num = string_delete(num,_dot_pos,1);
		} else {
			_dot_pos = string_length(num)+1;
		}
		
		var _start_pos = ((_dot_pos-1) mod 10)-10;
		var _pow = (_dot_pos-2) div 10;
		
		for(var i = _start_pos; i <= string_length(num); i += 10){
			self.num = __number_sum__(self,__number_multiply__(real(string_copy(num,max(i,0),10)),__number_power__(number(1000000000),_pow)));
			_pow -= 1;
		}
	}
}

function __number_multiply__(numb1,numb2){
	numb1 = variable_clone(numb1);
	numb2 = variable_clone(numb2);
	var _result_num = number(0);
	_result_num.num_sign = numb1.num_sign*numb2.num_sign;
	_result_num.num = array_create(array_length(numb1)+array_length(numb2),0);
	_result_num.fract_length = numb1.fract_length+numb2.fract_length;
	
	for(var i = 0; i < array_length(numb1.num); i++){
		for(var ii = 0; ii < array_length(numb2.num); ii++){
			var _val = numb1.num[i]*numb2.num[ii];
			var _pos = i-numb1.fract_length+ii-numb2.fract_length;
			var _temp_number = number();
		}
	}
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
	
	var _result_num = number(0);
	_result_num.num_sign = numb1.num_sign;
	_result_num.fract_length = numb1.fract_length;
	
	var _overed_value = int64(0);
	for(var i = 0; i < array_length(numb1.num); i++){
		_result_num.num[i] = numb1.num[i]+numb2.num[i]+_overed_value;
		_overed_value = (_result_num.num[i] & 0b1111111111111111111111111111111110000000000000000000000000000000) >> 31;
		_result_num.num[i] = _result_num.num[i] & 0b0000000000000000000000000000000001111111111111111111111111111111;
		
		if(_overed_value != 0 && i >= array_length(numb1.num)){
			array_push(numb1.num,0);
			array_push(numb2.num,0);
		}
	}
	
	return _result_num;
}