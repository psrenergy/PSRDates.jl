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

function days_difference(date1::DateTime, date2::DateTime)
    return convert(Dates.Day, (date1 - date2)).value
end
