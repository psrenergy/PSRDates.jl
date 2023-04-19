function is_leap_year(year::Int)
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
end

function year_to_decade(year::Int)
    return year - (year % 10)
end

function datetime_to_unix(date::DateTime)
    return (value(date) - Dates.UNIXEPOCH)
end

function date_to_epoch(day::Int, month::Int, year::Int)
    date = DateTime(year, month, day)
    return datetime_to_unix(date)
end

function week_to_epoch(week::Int, year::Int)
    if week < 10
        return date_to_epoch(1, 1, year) + (week - 1LL) * 7LL * 24LL * 60LL * 60LL * 1000LL
    else
        return date_to_epoch(5, 3, year) + (week - 10LL) * 7LL * 24LL * 60LL * 60LL * 1000LL
    end
end

function quarter_to_epoch(quarter::Int, year::Int)
    return date_to_epoch(1, (quarter - 1) * 3 + 1, year)
end

function year_day_to_epoch(day_of_year, year)
    return date_to_epoch(1, 1, year) + (day_of_year - 1LL) * 24LL * 60LL * 60LL * 1000LL
end