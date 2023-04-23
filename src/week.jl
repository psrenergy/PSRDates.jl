function week_to_epoch(week::Int, year::Int)
    if week < 10
        return date_to_epoch(1, 1, year) + (week - 1) * EPOCH_WEEK
    else
        return date_to_epoch(5, 3, year) + (week - 10) * EPOCH_WEEK
    end
end

function epoch_to_week(epoch::Int)
    datetime = epoch_to_datetime(epoch)
    month = Dates.month(datetime)
    year = Dates.year(datetime)
    days =
        if month < 3
            days_difference(datetime, DateTime(year, 1, 1))
        else
            days_difference(datetime, DateTime(year, 3, 1)) + 31 + 28
        end

    return min(floor(Int, days / 7) + 1, 52)
end

function stage_to_week(reference::PSRDateReference, stage::Int)
    current_stage = current_stage(reference, stage)
    initial_year = reference.initial_year

    year = floor(Int, current_stage / 52.0) + initial_year
    week = mod(current_stage, 52) + 1
    return week_to_epoch(week, year)

    return week, year
end
