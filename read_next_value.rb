def get_numer(pos, str)
    number = ""

    while str[pos] =~ /[[:digit:]]/ do 
        number << str[pos]
        pos += 1
    end

    number
end

def get_operator(pos, str)
    operator = ""

    while str[pos] =~ /[[:alpha:]]/ do 
        operator << str[pos]
        pos += 1
    end

    operator
end

def get_next(pos, str)
    substr = ""

    if str[pos].match(/[[:digit:]]/)
        substr << get_numer(pos, str)
    elsif str[pos].match(/[[:alpha:]]/)
        substr << get_operator(pos, str)
    else
        substr = str[pos]
    end

    substr
end