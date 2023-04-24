struct PSRDateReference
    stage_type::StageType
    initial_stage::Int
    initial_year::Int

    function PSRDateReference(stage_type::StageType, initial_stage::Int, initial_year::Int)
        if stage_type == STAGETYPE_WEEK
            if initial_stage < 1 || initial_stage > 52
                error("Invalid initial stage")
            end
        elseif stage_type == STAGETYPE_MONTH
            if initial_stage < 1 || initial_stage > 12
                error("Invalid initial stage")
            end
        elseif stage_type == STAGETYPE_YEAR
            if initial_stage != 1
                error("Invalid initial stage")
            end
        else
            error("Invalid stage type")
        end

        return new(stage_type, initial_stage, initial_year)
    end

    function PSRDateReference(stage_type::StageType, initial_year::Int)
        return PSRDateReference(stage_type, 1, initial_year)
    end
end

function stage_to_epoch(reference::PSRDateReference, stage::Int)
    stage_type = reference.stage_type

    if stage_type == STAGETYPE_WEEK
        week, year = stage_to_week(reference, stage)
        return week_to_epoch(week, year)
    elseif stage_type == STAGETYPE_MONTH
        month, year = stage_to_month(reference, stage)
        return month_to_epoch(month, year)
    elseif stage_type == STAGETYPE_YEAR
        year = stage_to_year(reference, stage)
        return year_to_epoch(year)
    else
        error("Invalid stage type")
    end

    return 0
end

function epoch_to_stage(reference::PSRDateReference, epoch::Int)
    stage_type = reference.stage_type

    if stage_type == STAGETYPE_WEEK
        return epoch_to_week(epoch)
    elseif stage_type == STAGETYPE_MONTH
        return epoch_to_month(epoch)
    elseif stage_type == STAGETYPE_YEAR
        return epoch_to_year(epoch)
    else
        error("Invalid stage type")
    end

    return 0
end
