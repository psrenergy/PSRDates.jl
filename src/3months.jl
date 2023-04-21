function stage_to_3months(reference::PSRDateReference, stage::Int)
    current_stage = current_stage(reference, stage)
    initial_year = reference.initial_year

    month = mod(current_stage, 4) + 1
    year = floor(Int, current_stage / 4.0) + initial_year
    
    return month, year
end