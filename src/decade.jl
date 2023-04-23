function year_to_decade(year::Int)
    return year - (year % 10)
end

function stage_to_decade(reference::PSRDateReference, stage::Int)
    year = stage_to_year(reference, stage)
    decade = year_to_decade(year)

    return decade
end
