function month_to_epoch(month::Int, year::Int)
    return date_to_epoch(1, month, year)
end

function epoch_to_month(epoch::Int)
    datetime = epoch_to_datetime(epoch)
    return Dates.month(datetime)
end

function stage_to_month(reference::PSRDateReference, stage::Int)
    current_stage = current_stage(reference, stage)
    initial_year = reference.initial_year

    month = mod(current_stage, 12) + 1
    year = floor(Int, current_stage / 12.0) + initial_year
    
    return month, year
end