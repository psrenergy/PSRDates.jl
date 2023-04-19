using Test

using PSRDates

function test_date()
    @test PSRDates.is_leap_year(1700) == false
    @test PSRDates.is_leap_year(1800) == false
    @test PSRDates.is_leap_year(1900) == false
    @test PSRDates.is_leap_year(2100) == false
    @test PSRDates.is_leap_year(2200) == false
    @test PSRDates.is_leap_year(2300) == false
    @test PSRDates.is_leap_year(2500) == false
    @test PSRDates.is_leap_year(2600) == false

    @test PSRDates.is_leap_year(1600) == true
    @test PSRDates.is_leap_year(2000) == true
    @test PSRDates.is_leap_year(2400) == true

    @test PSRDates.is_leap_year(1988) == true
    @test PSRDates.is_leap_year(1992) == true
    @test PSRDates.is_leap_year(1996) == true

    @test PSRDates.year_to_decade(1999) == 1990
    @test PSRDates.year_to_decade(2000) == 2000
    @test PSRDates.year_to_decade(2001) == 2000
    @test PSRDates.year_to_decade(2009) == 2000
    @test PSRDates.year_to_decade(2010) == 2010
    @test PSRDates.year_to_decade(2011) == 2010

    @show PSRDates.date_to_epoch(1, 1, 2000)
    # @test PSRDates.date_to_epoch(1, 1, 2000) == 946684800000
end

function test_reference()
    reference = PSRDateReference(STAGETYPE_MONTH, 1, 2000)

    # @test PSRDates.epoch(reference, 1) == 946684800000
end

function test_all()
    test_date()
    test_reference()
end

test_all()