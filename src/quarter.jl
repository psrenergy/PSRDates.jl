function quarter_to_epoch(quarter::Int, year::Int)
    return date_to_epoch(1, (quarter - 1) * 3 + 1, year)
end
