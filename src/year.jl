function is_leap_year(year::Int)
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
end

function epoch_to_year(epoch::Int)
    datetime = epoch_to_datetime(epoch)
    return Dates.year(datetime)
end