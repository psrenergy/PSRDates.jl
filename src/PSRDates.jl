module PSRDates

using Dates

const DAYS_IN_MONTH = Int[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

const EPOCH_SECOND = 1000
const EPOCH_MINUTE = 60 * EPOCH_SECOND
const EPOCH_HOUR = 60 * EPOCH_MINUTE
const EPOCH_DAY = 24 * EPOCH_HOUR
const EPOCH_WEEK = 7 * EPOCH_DAY

export
    PSRDateReference,
    StageType,
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
include("week.jl")
include("month.jl")
include("year.jl")
include("decade.jl")
include("cross.jl")

end
