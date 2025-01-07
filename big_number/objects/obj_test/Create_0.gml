/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
//show_message($"{number_power(number(4),number(-3))}")
//show_message($"{number_multiply(number(4),number(0.01),10)}")
show_message(number_string_dec(number("123123123000000000123123123")))
show_message(number_div(number("100000000000000000000"),number(10)))
//var _time = get_timer();
//show_debug_message(number_string_dec(number("11223344522222222222222222225"),false))
//show_message($"{(get_timer()-_time)/1000}ms")

var _time = get_timer();
for(var i = 0; i < 1000; i++){
	number(1000);
}
show_debug_message($"number(1000);\n{(get_timer()-_time)/1000000}ms")

var _time = get_timer();
for(var i = 0; i < 1000; i++){
	number("1000");
}
show_debug_message($"number(\"1000\");\n{(get_timer()-_time)/1000000}ms")

var _numb = number(1000);
var _time = get_timer();
for(var i = 0; i < 1000; i++){
	number_multiply(_numb,_numb);
}
show_debug_message($"number_multiply(number(1000),number(1000));\n{(get_timer()-_time)/1000000}ms")

var _numb = number("100000000000000000000");
var _time = get_timer();
for(var i = 0; i < 1000; i++){
	number_multiply(_numb,_numb);
}
show_debug_message($"number_multiply(number(100000000000000000000),number(100000000000000000000));\n{(get_timer()-_time)/1000000}ms")

var _numb = number(1000);
var _time = get_timer();
for(var i = 0; i < 1000; i++){
	number_sum(_numb,_numb);
}
show_debug_message($"number_sum(1000,1000);\n{(get_timer()-_time)/1000000}ms")

var _numb = number("100000000000000000000");
var _time = get_timer();
for(var i = 0; i < 1000; i++){
	number_sum(_numb,_numb);
}
show_debug_message($"number_sum(100000000000000000000,100000000000000000000);\n{(get_timer()-_time)/1000000}ms")

var _numb = number(1000);
var _time = get_timer();
for(var i = 0; i < 1000; i++){
	number_sub(_numb,_numb);
}
show_debug_message($"number_sub(1000,1000);\n{(get_timer()-_time)/1000000}ms")

var _numb = number("100000000000000000000");
var _time = get_timer();
for(var i = 0; i < 1000; i++){
	number_sub(_numb,_numb);
}
show_debug_message($"number_sub(100000000000000000000,100000000000000000000);\n{(get_timer()-_time)/1000000}ms")
var _numb = number(1000);

var _numb = number(1000);
var _numb2 = number(900);
var _time = get_timer();
for(var i = 0; i < 1000; i++){
	number_div(_numb,_numb2);
}
show_debug_message($"number_div(1000,900);\n{(get_timer()-_time)/1000000}ms")

var _numb = number("100000000000000000000");
var _numb2 = number("900");
var _time = get_timer();
for(var i = 0; i < 1000; i++){
	number_div(_numb,_numb2);
}
show_debug_message($"number_div(100000000000000000000,900);\n{(get_timer()-_time)/1000000}ms")

var _numb = number(1000);
var _numb2 = number(900);
var _time = get_timer();
for(var i = 0; i < 1000; i++){
	number_mod(_numb,_numb2);
}
show_debug_message($"number_mod(1000,900);\n{(get_timer()-_time)/1000000}ms")

var _numb = number("100000000000000000000");
var _numb2 = number("900");
var _time = get_timer();
for(var i = 0; i < 1000; i++){
	number_mod(_numb,_numb2);
}
show_debug_message($"number_mod(100000000000000000000,900);\n{(get_timer()-_time)/1000000}ms")


show_message(
	number_string_bin(
		number_multiply(number("2.5"),number("1.2"))
	)
)
/*
show_message(
	number_string_bin(
		number_reciprocal(number(2))
	)
)