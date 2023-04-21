# function stage_to_day(reference::PSRDateReference, stage::Int)
#     initial_stage = reference.initial_stage
#     initial_year = reference.initial_year

#     current_stage = initial_stage + stage - 2

#     month = mod(current_stage, 12) + 1
#     year = floor(Int, current_stage / 12.0) + initial_year
    
#     return month, year
# end

# isso ta errado :point_up