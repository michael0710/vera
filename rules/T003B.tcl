#!/usr/bin/tclsh
# Some keywords should be followed by a newline

set keywords {
    class
    enum
    struct
    union
}

proc isKeyword {s} {
    global keywords
    return [expr [lsearch $keywords $s] != -1]
}

set state "other"
foreach f [getSourceFileNames] {
    foreach t [getTokens $f 1 0 -1 -1 {}] {
        set tokenValue [lindex $t 0]
        set tokenName [lindex $t 3]
        if {$state == "keyword"} {
            if {$tokenName == "newline"} {
                set state "other"
            } else {
                report $f $lineNumber "keyword \'${keywordValue}\' not followed by a new line"
                set state "other"
            }
        } else {
            if [isKeyword $tokenName] {
                set state "keyword"
                set lineNumber [lindex $t 1]
                set keywordValue [lindex $t 0]
            }
        }
    }
}
