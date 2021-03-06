CREATE EXTENSION IF NOT EXISTS pg_libphonenumber;

--Test phone number parsing
select parse_phone_number('555-555-5555', 'US');
--These two should produce errors because the number is too long.
--Produces an error in pg-libphonenumber's code
select parse_phone_number('555-555-5555555555', 'US');
--Produces an error from libphonenumber
select parse_phone_number('555-555-55555555555', 'US');

-- Do we get correct country codes?
-- TODO: expand.
select phone_number_country_code(parse_phone_number('+1-555-555-5555', 'USA'));
