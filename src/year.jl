function is_leap_year(year::Int)
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
end

function year_to_epoch(year::Int)
    return date_to_epoch(1, 1, year)
end

function epoch_to_year(epoch::Int)
    datetime = epoch_to_datetime(epoch)
    return Dates.year(datetime)
end

function stage_to_year(reference::PSRDateReference, stage::Int)
    initial_year = reference.initial_year

    year = stage + initial_year - 1
    return year
end
