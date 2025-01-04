/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
//show_message($"{number_power(number(4),number(-3))}")
//show_message($"{number_multiply(number(4),number(0.01),10)}")
show_message(123)

var _time = get_timer();

show_debug_message(number_string_dec(number("11223344522222222222222222225"),false))

show_message($"{(get_timer()-_time)/1000}ms")

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