function year_day_to_epoch(year_day::Int, year::Int)
    return date_to_epoch(1, 1, year) + (year_day - 1) * EPOCH_DAY
end

function epoch_to_year_day(epoch::Int)
    datetime = epoch_to_datetime(epoch)
    year = Dates.year(datetime)
    year_day = days_difference(datetime, DateTime(year, 1, 1)) + 1

    if is_leap_year(Dates.year(year)) && year_day > 59
        return year_day - 1
    else
        return year_day
    end
end