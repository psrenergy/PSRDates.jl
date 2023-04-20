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
        year = floor(Int, current_stage / 365.0) + initial_year
        year_day = owl::math::mod(current_stage, 365) + 1
        if is_leap_year(year) && year_day > 59 
            year_day += 1
        end
        return year_day_to_epoch(year_day, year)
    elseif stage_type == STAGETYPE_WEEK
        year = floor(Int, current_stage / 52.0) + initial_year
        week = mod(current_stage, 52) + 1
        return week_to_epoch(week, year)
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

function epoch_to_stage(reference::PSRDateReference, epoch::Int)
    stage_type = reference.stage_type

    if stage_type == STAGETYPE_DAY
        return epoch_to_year_day(epoch)
    elseif stage_type == STAGETYPE_WEEK
        return epoch_to_week(epoch)
    elseif stage_type == STAGETYPE_MONTH
        return epoch_to_month(epoch)
    elseif stage_type == STAGETYPE_YEAR
        return epoch_to_year(epoch)
    else
        error("Invalid stage type")
    end
    # switch (stage_type) {
    #     case PSR_STAGETYPE_DAILY: return Datetime::yearDayFromEpoch(epoch)
    #     case PSR_STAGETYPE_MONTHLY: return Datetime::monthFromEpoch(epoch)
    #     case PSR_STAGETYPE_WEEKLY: return Datetime::weekFromEpoch(epoch)
    #     case PSR_STAGETYPE_YEARLY: return Datetime::yearFromEpoch(epoch)
    #     case PSR_STAGETYPE_DECENNIAL: return Datetime::decadeFromEpoch(epoch)
    #     case PSR_STAGETYPE_UNKNOWN: Logger::fatalErrorContactPSR("7f5em12a7o") break
    #     case PSR_STAGETYPE_QUARTERLY: Logger::fatalErrorContactPSR("zcesahbva6") break
    #     case PSR_STAGETYPE_HOURLY: Logger::fatalErrorContactPSR("prdv9bqpub") break
    #     case PSR_STAGETYPE_13MONTHLY: Logger::fatalErrorContactPSR("l13iznfb15") break
    #     case PSR_STAGETYPE_BIMONTHLY: Logger::fatalErrorContactPSR("l49hjfkuim") break
    #     case PSR_STAGETYPE_TRIANNUALLY: Logger::fatalErrorContactPSR("rk2ejwu61z") break
    #     case PSR_STAGETYPE_SEMIANNUALLY: Logger::fatalErrorContactPSR("ykrdudgwie") break
    #     default: Logger::fatalErrorContactPSR("2dro5446x0")
    # }
    return 0
end

# epoch = PSRC.PSRParsers_toStageDate(stage, stage_type, 1, initial_stage, initial_year)
