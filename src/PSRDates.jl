module PSRDates

using Dates

const DAYS_IN_MONTH = Int[
    31,
    28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31,
]

export 
    PSRDateReference,
    STAGETYPE_UNKNOWN,
    STAGETYPE_WEEK,
    STAGETYPE_MONTH,
    STAGETYPE_3MONTHS,
    STAGETYPE_DAY,
    STAGETYPE_13MONTHS,
    STAGETYPE_2MONTHS,
    STAGETYPE_4MONTHS,
    STAGETYPE_6MONTHS,
    STAGETYPE_YEAR,
    STAGETYPE_DECADE,
    DAYS_IN_MONTH

include("stagetype.jl")
include("date.jl")
include("reference.jl")

end
