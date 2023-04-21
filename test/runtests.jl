using Dates
using PSRDates
using Test

const EPOCH_2000_01_01 = 946684800000

function test_date()
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

    @test PSRDates.year_to_decade(1999) == 1990
    @test PSRDates.year_to_decade(2000) == 2000
    @test PSRDates.year_to_decade(2001) == 2000
    @test PSRDates.year_to_decade(2009) == 2000
    @test PSRDates.year_to_decade(2010) == 2010
    @test PSRDates.year_to_decade(2011) == 2010

    @test PSRDates.date_to_epoch(1, 1, 2000) == EPOCH_2000_01_01

    @test PSRDates.epoch_to_datetime(EPOCH_2000_01_01) == DateTime(2000, 1, 1)
end

function test_week()
    for year in 2000:2005
        year_day = 1
        year_epoch = PSRDates.date_to_epoch(1, 1, year)

        for week in 1:52

        end

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
end

function test_reference()
    reference = PSRDateReference(STAGETYPE_MONTH, 1, 2000)

    @test PSRDates.epoch(reference, 1) == 946684800000

    @show PSRDates.stage(reference, PSRDates.epoch(reference, 2))
    @show PSRDates.stage(reference, PSRDates.epoch(reference, 3))
    @show PSRDates.stage(reference, PSRDates.epoch(reference, 4))
    @show PSRDates.stage(reference, PSRDates.epoch(reference, 5))
    @show PSRDates.stage(reference, PSRDates.epoch(reference, 6))
    @show PSRDates.stage(reference, PSRDates.epoch(reference, 7))
    @show PSRDates.stage(reference, PSRDates.epoch(reference, 8))
    @show PSRDates.stage(reference, PSRDates.epoch(reference, 9))
    @show PSRDates.stage(reference, PSRDates.epoch(reference, 10))
    @show PSRDates.stage(reference, PSRDates.epoch(reference, 11))
    @show PSRDates.stage(reference, PSRDates.epoch(reference, 12))
    @show PSRDates.stage(reference, PSRDates.epoch(reference, 13))
    @show PSRDates.stage(reference, PSRDates.epoch(reference, 14))
end

function test_all()
    test_date()
    test_week()
    # test_reference()
end

test_all()