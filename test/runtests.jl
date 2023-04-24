using Dates
using PSRDates
using Test

const EPOCH_2000_01_01 = 946684800000

function test_date()
    @test PSRDates.date_to_epoch(1, 1, 2000) == EPOCH_2000_01_01

    @test PSRDates.epoch_to_datetime(EPOCH_2000_01_01) == DateTime(2000, 1, 1)
end

function test_week()
    for year in 2000:2005
        year_day = 1
        year_epoch = PSRDates.date_to_epoch(1, 1, year)

        for month in 1:12
            for day in 1:DAYS_IN_MONTH[month]
                week = min(floor(Int, (year_day - 1) / 7) + 1, 52)

                @test PSRDates.epoch_to_week(PSRDates.date_to_epoch(day, month, year)) == week
                
                epoch = year_epoch + (week - 1) * PSRDates.EPOCH_WEEK
                if PSRDates.is_leap_year(year) && week > 9
                    epoch += PSRDates.EPOCH_DAY
                end
                @test PSRDates.week_to_epoch(week, year) == epoch

                year_day += 1
            end
        end
    end

    reference = PSRDateReference(STAGETYPE_WEEK, 2, 2000)

    @test PSRDates.stage_to_week(reference, -2) == (51, 1999)
    @test PSRDates.stage_to_week(reference, -1) == (52, 1999)
    @test PSRDates.stage_to_week(reference, 0) == (1, 2000)
    @test PSRDates.stage_to_week(reference, 1) == (2, 2000)
    @test PSRDates.stage_to_week(reference, 2) == (3, 2000)
    @test PSRDates.stage_to_week(reference, 3) == (4, 2000)
    @test PSRDates.stage_to_week(reference, 50) == (51, 2000)
    @test PSRDates.stage_to_week(reference, 51) == (52, 2000)
    @test PSRDates.stage_to_week(reference, 52) == (1, 2001)
    @test PSRDates.stage_to_week(reference, 53) == (2, 2001)
end

function test_month()
    for year in 2000:2005
        year_day = 1
        year_epoch = PSRDates.date_to_epoch(1, 1, year)

        for month in 1:12 
            for day in 1:DAYS_IN_MONTH[month]
                @test PSRDates.epoch_to_month(PSRDates.date_to_epoch(day, month, year)) == month

                epoch = year_epoch + sum(DAYS_IN_MONTH[1:(month - 1)]) * PSRDates.EPOCH_DAY
                if PSRDates.is_leap_year(year) && year_day > 59
                    epoch += PSRDates.EPOCH_DAY
                end
                @test PSRDates.month_to_epoch(month, year) == epoch

                year_day += 1
            end
        end
    end

    reference = PSRDateReference(STAGETYPE_MONTH, 2, 2000)

    @test PSRDates.stage_to_month(reference, -1) == (12, 1999)
    @test PSRDates.stage_to_month(reference, 0) == (1, 2000)
    @test PSRDates.stage_to_month(reference, 1) == (2, 2000)
    @test PSRDates.stage_to_month(reference, 2) == (3, 2000)
    @test PSRDates.stage_to_month(reference, 3) == (4, 2000)
    @test PSRDates.stage_to_month(reference, 4) == (5, 2000)
    @test PSRDates.stage_to_month(reference, 5) == (6, 2000)
    @test PSRDates.stage_to_month(reference, 6) == (7, 2000)
    @test PSRDates.stage_to_month(reference, 7) == (8, 2000)
    @test PSRDates.stage_to_month(reference, 8) == (9, 2000)
    @test PSRDates.stage_to_month(reference, 9) == (10, 2000)
    @test PSRDates.stage_to_month(reference, 10) == (11, 2000)
    @test PSRDates.stage_to_month(reference, 11) == (12, 2000)
    @test PSRDates.stage_to_month(reference, 12) == (1, 2001)
end

function test_year()
    @test PSRDates.is_leap_year(1600) == true
    @test PSRDates.is_leap_year(1700) == false
    @test PSRDates.is_leap_year(1800) == false
    @test PSRDates.is_leap_year(1900) == false
    @test PSRDates.is_leap_year(2000) == true
    @test PSRDates.is_leap_year(2100) == false
    @test PSRDates.is_leap_year(2200) == false
    @test PSRDates.is_leap_year(2300) == false
    @test PSRDates.is_leap_year(2400) == true
    @test PSRDates.is_leap_year(2500) == false
    @test PSRDates.is_leap_year(2600) == false

    @test PSRDates.is_leap_year(1988) == true
    @test PSRDates.is_leap_year(1992) == true
    @test PSRDates.is_leap_year(1996) == true

    for year in 2000:2005
        year_day = 1
        year_epoch = PSRDates.date_to_epoch(1, 1, year)

        for month in 1:12 
            for day in 1:DAYS_IN_MONTH[month]
                @test PSRDates.epoch_to_year(PSRDates.date_to_epoch(day, month, year)) == year
                @test PSRDates.year_to_epoch(year) == year_epoch

                year_day += 1
            end
        end

        year_epoch = PSRDates.date_to_epoch(1, 1, year)
        @test PSRDates.epoch_to_year(year_epoch) == year
    end

    reference = PSRDateReference(STAGETYPE_YEAR, 2000)

    @test PSRDates.stage_to_year(reference, -1) == 1998
    @test PSRDates.stage_to_year(reference, 0) == 1999
    @test PSRDates.stage_to_year(reference, 1) == 2000
    @test PSRDates.stage_to_year(reference, 2) == 2001
end

function test_decade()
    @test PSRDates.year_to_decade(1999) == 1990
    @test PSRDates.year_to_decade(2000) == 2000
    @test PSRDates.year_to_decade(2001) == 2000
    @test PSRDates.year_to_decade(2009) == 2000
    @test PSRDates.year_to_decade(2010) == 2010
    @test PSRDates.year_to_decade(2011) == 2010
end

function test_all()
    test_date()
    test_week()
    test_month()
    test_year()
    test_decade()
end

test_all()