using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Numerics;
using System.Globalization;

namespace binary_translator
{
    /// <summary>
    /// MainWindow.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        public static string BinaryToDecimal(string binary)
        {
            if (string.IsNullOrEmpty(binary))
            {
                return "";
            }

            try
            {
                BigInteger result = 0;
                foreach (char c in binary)
                {
                    result <<= 1; // 결과를 2배 (왼쪽으로 1비트 시프트)

                    if (c == '1')
                    {
                        result += 1;
                    }
                    else if (c != '0')
                    {
                        throw new ArgumentException("유효하지 않은 이진수 문자입니다. '0' 또는 '1'만 허용됩니다.");
                    }
                }
                return result.ToString();
            } catch (Exception e)
            {
                return "";
            }
        }

        public static string DecimalToBinary(string decimalString)
        {
            try
            {
                // 음수 처리 (필요 시)
                bool isNegative = false;
                if (decimalString.StartsWith("-"))
                {
                    isNegative = true;
                    decimalString = decimalString.Substring(1);
                }

                // 10진수 문자열을 BigInteger로 변환
                BigInteger.TryParse(decimalString, out BigInteger decimalValue);

                // 0의 경우 특별 처리
                if (decimalValue.IsZero)
                    return "0";

                // 10진수를 이진수로 변환
                string binary = string.Empty;
                while (decimalValue > 0)
                {
                    binary = (decimalValue % 2) + binary;
                    decimalValue /= 2;
                }

                // 음수인 경우 앞에 '-' 추가 (필요 시)
                if (isNegative)
                    binary = "-" + binary;

                return binary;
            }
            catch (Exception e)
            {
                return "";
            }
        }
        public static string DecimalToBinary_fract(string decimalString)
        {
            try
            {
                // 음수 처리 (필요 시)
                bool isNegative = false;
                if (decimalString.StartsWith("-"))
                {
                    isNegative = true;
                    decimalString = decimalString.Substring(1);
                }

                // 10진수 문자열을 BigInteger로 변환
                BigInteger.TryParse(decimalString, out BigInteger decimalValue);

                // 0의 경우 특별 처리
                if (decimalValue.IsZero)
                    return "0";

                // 10진수를 이진수로 변환
                string binary = string.Empty;
                while (decimalValue > 0)
                {
                    binary = (decimalValue % 2) + binary;
                    decimalValue /= 2;
                }

                // 음수인 경우 앞에 '-' 추가 (필요 시)
                if (isNegative)
                    binary = "-" + binary;

                return binary;
            }
            catch (Exception e)
            {
                return "";
            }
        }

        public static string BinaryFractionToDecimal(string binaryStr)
        {
            try
            {
                if (string.IsNullOrEmpty(binaryStr))
                    throw new ArgumentException("입력 문자열은 비어 있을 수 없습니다.");

                decimal decimalValue = 0m;
                decimal two = 2m;

                for (int i = 0; i < binaryStr.Length; i++)
                {
                    char bit = binaryStr[i];
                    if (bit == '1')
                    {
                        // 각 비트의 위치에 따라 값을 더합니다.
                        decimalValue += 1m / (Pow(two, i + 1));
                    }
                    else if (bit != '0')
                    {
                        throw new ArgumentException("입력 문자열은 '0'과 '1'로만 구성되어야 합니다.");
                    }
                }

                // 결과를 문자열로 변환하고 "0."을 접두사로 붙입니다.
                // Decimal 객체는 자동으로 "0."을 포함하지 않으므로 직접 추가해야 합니다.
                return "0" + decimalValue.ToString(CultureInfo.InvariantCulture).TrimStart('0');
            }
            catch (Exception e)
            {
                return "";
            }
        }
        public static decimal Pow(decimal baseValue, int exponent)
        {
            if (exponent < 0)
                throw new ArgumentException("Exponent should be non-negative.");

            decimal result = 1m;
            for (int i = 0; i < exponent; i++)
            {
                result *= baseValue;
            }
            return result;
        }
        private void ResultBox_Text_Input(object sender, TextChangedEventArgs e)
        {
            if (translate_result_box.IsFocused)
            {
                source_box.Text = BinaryToDecimal(translate_result_box.Text);
            }
        }
        private void SourceBox_Text_Changed(object sender, TextChangedEventArgs e)
        {
            if (source_box.IsFocused)
            {
                translate_result_box.Text = DecimalToBinary(source_box.Text);
            }
            translate_result_box_fract.Text = BinaryFractionToDecimal(translate_result_box.Text);
        }
    }
}
