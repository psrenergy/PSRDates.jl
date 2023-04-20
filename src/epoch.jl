function datetime_to_epoch(date::DateTime)
    return Dates.value(date) - Dates.UNIXEPOCH
end

function epoch_to_datetime(epoch::Int)
    return DateTime(Dates.UTM(Dates.UNIXEPOCH + epoch))
end

function date_to_epoch(day::Int, month::Int, year::Int)
    date = DateTime(year, month, day)
    return datetime_to_epoch(date)
end

function week_to_epoch(week::Int, year::Int)
    if week < 10
        return date_to_epoch(1, 1, year) + (week - 1) * EPOCH_WEEK
    else
        return date_to_epoch(5, 3, year) + (week - 10) * EPOCH_WEEK
    end
end

function quarter_to_epoch(quarter::Int, year::Int)
    return date_to_epoch(1, (quarter - 1) * 3 + 1, year)
end

function year_day_to_epoch(year_day::Int, year::Int)
    return date_to_epoch(1, 1, year) + (year_day - 1) * EPOCH_DAY
end

function epoch_to_year(epoch::Int)
    datetime = epoch_to_datetime(epoch)
    return Dates.year(datetime)
end

function epoch_to_month(epoch::Int)
    datetime = epoch_to_datetime(epoch)
    return Dates.month(datetime)
end

function epoch_to_year_day(epoch::Int)
    datetime = epoch_to_datetime(epoch)
    year = Dates.year(datetime)
    year_day = Int(convert(Dates.Day, (datetime - DateTime(year, 1, 1)))) + 1

    if is_leap_year(Dates.year(year)) && year_day > 59
        return year_day - 1
    else
        return year_day
    end
end