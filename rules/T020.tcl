#!/usr/bin/tclsh
# The keywords enum struct and union shall only be used with a preceeding typedef keyword.

set keywords {
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
        if {$state == "typedef"} {
            if {$tokenName == "space"} {
                set state "typedef"
            } else {
                set state "other"
            }
        } else {
            if {$tokenName == "typedef"} {
		set state "typedef"
            } elseif [isKeyword $tokenName] {
		set state "other"
		set lineNumber [lindex $t 1]
		set keywordValue [lindex $t 0]
		report $f $lineNumber "keyword \'${keywordValue}\' not preceeded by the typedef keyword"
            }
        }
    }
}
