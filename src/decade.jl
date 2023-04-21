function year_to_decade(year::Int)
    return year - (year % 10)
end