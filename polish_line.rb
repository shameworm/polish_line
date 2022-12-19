require_relative "read_next_value"

OPERATOR_PRIORITY = {
    "(" => 0,
    "+" => 1,
    "-" => 1,
    "*" => 2,
    "/" => 2,
    "^" => 3, 
    "sin" => 4,
    "cos" => 4,
    "tan" => 4,
    "cot" => 4
}

TRIGONOMETRICAL_OPERATOR = ["sin", "cos", "tan", "cot"]
SIMPLE_OPERATION = ["+", "-", "/", "*", "^"]

def calculate_single_opr(opr, value)
    res = 0.0

    if opr == "cos"
        res = Math::cos(value)
    elsif opr == "sin"
        res = Math::sin(value)
    elsif opr == "tan"
        res = Math::tan(value)
    elsif opr == "cot"
        res = Math::cot(value)
    end

    res
end

def calculate_binary_opr(opr, number1, number2)
    res = 0.0

    if opr == "+"
        res = number1 + number2
    elsif opr == "-"
        res = number1 - number2
    elsif opr == "*"
        res = number1 * number2
    elsif opr == "/"
        begin
            res = number1 / number2
        rescue ZeroDivisionError => error
            puts error.message
            return 0
        end
    elsif opr == "^"
        res = number1.pow(number2)
    end

    res
end

def calculate_polish_line(polishLine)
    arr_res = Array.new

    i = 0
    while i < polishLine.length do 
        ch =  get_next(i, polishLine)

        i += ch.length()
        if ch =~ /[[:blank:]]/ 
            next
        end

        if ch =~ /[[:digit:]]/
            arr_res.push(ch)
        else
            res = 0.0
            if TRIGONOMETRICAL_OPERATOR.include?(ch)
                val = arr_res.pop.to_f
                res = calculate_single_opr(ch, val)
            elsif SIMPLE_OPERATION.include?(ch)
                b = arr_res.pop.to_f
                a = arr_res.pop.to_f
                res = calculate_binary_opr(ch, a, b)
            else
                puts "Error in calculate_polish_line(), non undefined operation"
                exit(1)
            end
            arr_res.push(res)
        end
    end

    arr_res.pop
end


def parse_in_polish_line(simpleLine)
    polishLine = ""
    arr_opp = Array.new

    i = 0
    while i < simpleLine.length do 
        ch = get_next(i, simpleLine)

        i += ch.length()
        if ch =~ /[[:blank:]]/ 
            next
        end

        if ch =~ /[[:digit:]]/
            polishLine << ch << " "
        elsif ch == "("
            arrcOperation.push(ch)
        elsif ch == ")"
            while arrcOperation.last != "(" do
                polishLine << arrcOperation.pop << " "
            end

            arrcOperation.pop
        else
            if arrcOperation.empty? || 
                OPERATOR_PRIORITY[arrcOperation.last] < OPERATOR_PRIORITY[ch]
                arrcOperation.push(ch)
            else
                while !arr_opp.empty? && 
                    OPERATOR_PRIORITY[arr_opp.last] >= OPERATOR_PRIORITY[ch] do
                    polishLine << arr_opp.pop << " "
                end
                
                arr_opp.push(ch)
            end
        end
    end

    while !arr_opp.empty?
        polishLine << arr_opp.pop
    end

    polishLine
end

def main
    puts "Common mate expression: "
    mt_expression = gets.chomp
    polish_line = parse_in_polish_line(mt_expression)
    calline =  calculate_polish_line(polish_line)
    
    puts polish_line
    puts calline
end

main()