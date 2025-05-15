using PSRDates

using Aqua
using Dates
using Test

include("aqua.jl")

const EPOCH_2000_01_01 = 946684800000

function test_date()
    @test PSRDates.date_to_epoch(1, 1, 2000) == EPOCH_2000_01_01

    @test PSRDates.epoch_to_datetime(EPOCH_2000_01_01) == DateTime(2000, 1, 1)

    return nothing
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

    reference = PSRDateReference(StageType.WEEK, 2, 2000)

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

    return nothing
end

function test_month()
    for year in 2000:2005
        year_day = 1
        year_epoch = PSRDates.date_to_epoch(1, 1, year)

        for month in 1:12
            for day in 1:DAYS_IN_MONTH[month]
                @test PSRDates.epoch_to_month(PSRDates.date_to_epoch(day, month, year)) == month

                epoch = year_epoch + sum(DAYS_IN_MONTH[1:(month-1)]) * PSRDates.EPOCH_DAY
                if PSRDates.is_leap_year(year) && year_day > 59
                    epoch += PSRDates.EPOCH_DAY
                end
                @test PSRDates.month_to_epoch(month, year) == epoch

                year_day += 1
            end
        end
    end

    reference = PSRDateReference(StageType.MONTH, 2, 2000)

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

    return nothing
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

                for hour in 0:23
                    year_hour_epoch = year_epoch + (year_day - 1) * PSRDates.EPOCH_DAY + hour * PSRDates.EPOCH_HOUR
                    @test PSRDates.year_hour_to_epoch(year, (year_day - 1) * 24 + hour) == year_hour_epoch
                end

                year_day += 1
            end
        end

        year_epoch = PSRDates.date_to_epoch(1, 1, year)
        @test PSRDates.epoch_to_year(year_epoch) == year
    end

    reference = PSRDateReference(StageType.YEAR, 2000)

    @test PSRDates.stage_to_year(reference, -1) == 1998
    @test PSRDates.stage_to_year(reference, 0) == 1999
    @test PSRDates.stage_to_year(reference, 1) == 2000
    @test PSRDates.stage_to_year(reference, 2) == 2001

    return nothing
end

function test_decade()
    @test PSRDates.year_to_decade(1999) == 1990
    @test PSRDates.year_to_decade(2000) == 2000
    @test PSRDates.year_to_decade(2001) == 2000
    @test PSRDates.year_to_decade(2009) == 2000
    @test PSRDates.year_to_decade(2010) == 2010
    @test PSRDates.year_to_decade(2011) == 2010

    return nothing
end

function test_cross()
    @test PSRDates.year_hour_to_month(1) == 1
    @test PSRDates.year_hour_to_month(744 + 0) == 1
    @test PSRDates.year_hour_to_month(744 + 1) == 2
    @test PSRDates.year_hour_to_month(744 + 672 + 0) == 2
    @test PSRDates.year_hour_to_month(744 + 672 + 1) == 3
    @test PSRDates.year_hour_to_month(744 + 672 + 744 + 0) == 3
    @test PSRDates.year_hour_to_month(744 + 672 + 744 + 1) == 4
    @test PSRDates.year_hour_to_month(744 + 672 + 744 + 720 + 0) == 4
    @test PSRDates.year_hour_to_month(744 + 672 + 744 + 720 + 1) == 5
    @test PSRDates.year_hour_to_month(744 + 672 + 744 + 720 + 744 + 0) == 5
    @test PSRDates.year_hour_to_month(744 + 672 + 744 + 720 + 744 + 1) == 6
    @test PSRDates.year_hour_to_month(744 + 672 + 744 + 720 + 744 + 720 + 0) == 6
    @test PSRDates.year_hour_to_month(744 + 672 + 744 + 720 + 744 + 720 + 1) == 7
    @test PSRDates.year_hour_to_month(744 + 672 + 744 + 720 + 744 + 720 + 744 + 0) == 7
    @test PSRDates.year_hour_to_month(744 + 672 + 744 + 720 + 744 + 720 + 744 + 1) == 8
    @test PSRDates.year_hour_to_month(744 + 672 + 744 + 720 + 744 + 720 + 744 + 744 + 0) == 8
    @test PSRDates.year_hour_to_month(744 + 672 + 744 + 720 + 744 + 720 + 744 + 744 + 1) == 9
    @test PSRDates.year_hour_to_month(744 + 672 + 744 + 720 + 744 + 720 + 744 + 744 + 720 + 0) == 9
    @test PSRDates.year_hour_to_month(744 + 672 + 744 + 720 + 744 + 720 + 744 + 744 + 720 + 1) == 10
    @test PSRDates.year_hour_to_month(744 + 672 + 744 + 720 + 744 + 720 + 744 + 744 + 720 + 744 + 0) == 10
    @test PSRDates.year_hour_to_month(744 + 672 + 744 + 720 + 744 + 720 + 744 + 744 + 720 + 744 + 1) == 11
    @test PSRDates.year_hour_to_month(744 + 672 + 744 + 720 + 744 + 720 + 744 + 744 + 720 + 744 + 720 + 0) == 11
    @test PSRDates.year_hour_to_month(744 + 672 + 744 + 720 + 744 + 720 + 744 + 744 + 720 + 744 + 720 + 1) == 12

    return nothing
end

function test_all()
    @testset "Aqua" begin
        test_aqua()
    end

    @testset "Date" begin
        test_date()
    end

    @testset "Week" begin
        test_week()
    end

    @testset "Month" begin
        test_month()
    end

    @testset "Year" begin
        test_year()
    end

    @testset "Decade" begin
        test_decade()
    end

    @testset "Cross" begin
        test_cross()
    end

    return nothing
end

test_all()
