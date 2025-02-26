function year_hour_to_month(year::Integer, hour::Integer)
    epoch = year_hour_to_epoch(year, hour)
    return epoch_to_month(epoch)
end