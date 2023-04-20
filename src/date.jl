function is_leap_year(year::Int)
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
end

function year_to_decade(year::Int)
    return year - (year % 10)
end
