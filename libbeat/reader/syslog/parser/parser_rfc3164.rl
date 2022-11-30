// Code generated by ragel. DO NOT EDIT.
package syslog

import (
    "io"
    "time"

    "go.uber.org/multierr"
)

%%{
    machine rfc3164_parser;

    write data;
}%%

// parseRFC3164 parses an RFC 3164-formatted syslog message. loc is used to enrich
// timestamps that lack a time zone.
func parseRFC3164(data string, loc *time.Location) (message, error) {
    var errs error
    var p, cs, tok int

    pe := len(data)
    eof := len(data)
    m := message{
        priority: -1,
    }

    %%{
        include common "common.rl";
        include rfc3164 "rfc3164.rl";

        main := (priority? timestamp sp hostname sp msg) $err(err_eof);

        write init;
        write exec;
    }%%

    return m, errs
}