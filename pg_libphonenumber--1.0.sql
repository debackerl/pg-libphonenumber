-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION pg_libphonenumber" to load this file. \quit

CREATE TYPE phone_number;

CREATE FUNCTION phone_number_in(cstring) RETURNS phone_number
    LANGUAGE c IMMUTABLE STRICT
    AS 'pg_libphonenumber', 'phone_number_in';

CREATE FUNCTION phone_number_out(phone_number) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS 'pg_libphonenumber', 'phone_number_out';

CREATE FUNCTION phone_number_recv(internal) RETURNS phone_number
    LANGUAGE c IMMUTABLE STRICT
    AS 'pg_libphonenumber', 'phone_number_recv';

CREATE FUNCTION phone_number_send(phone_number) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS 'pg_libphonenumber', 'phone_number_send';

CREATE TYPE phone_number (
    INTERNALLENGTH = 64,
    INPUT = phone_number_in,
    OUTPUT = phone_number_out,
    RECEIVE = phone_number_recv,
    SEND = phone_number_send,
    ALIGNMENT = double,
    STORAGE = plain
);

