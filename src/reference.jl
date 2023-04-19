struct PSRDateReference
    stage_type::StageType
    initial_stage::Int
    initial_year::Int
end

function epoch(reference::PSRDateReference, stage::Int)
    stage_type = reference.stage_type
    initial_stage = reference.initial_stage
    initial_year = reference.initial_year

    current_stage = initial_stage + stage - 2

    if stage_type == STAGETYPE_DAY
        error("Not implemented yet")
    elseif stage_type == STAGETYPE_WEEK
        error("Not implemented yet")
    elseif stage_type == STAGETYPE_3MONTHS
        year = floor(Int, current_stage / 4.0) + initial_year
        month = mod(current_stage, 4) + 1
        return date_to_epoch(1, month, year)
    elseif stage_type == STAGETYPE_MONTH
        year = floor(Int, current_stage / 12.0) + initial_year
        month = mod(current_stage, 12) + 1
        return date_to_epoch(1, month, year)
    elseif stage_type == STAGETYPE_YEAR
        year = stage + initial_year - 1
        return date_to_epoch(1, 1, year)
    elseif stage_type == STAGETYPE_DECADE
        year = stage + initial_year - 1
        decade = year_to_decade(year)
        return date_to_epoch(1, 1, decade)
    else
        error("Invalid stage type")
    end

    return 0
end

# epoch = PSRC.PSRParsers_toStageDate(stage, stage_type, 1, initial_stage, initial_year)
