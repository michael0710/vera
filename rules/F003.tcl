#!/usr/bin/tclsh
# Each header file shall contain an include guard consisting of the filename in uppercase letters and the postfix "_H_INCLUDED"

set state "search_guard"
foreach f [getSourceFileNames] {
    if {[string match *.h $f]} {
	foreach t [getTokens $f 1 0 -1 -1 {}] {
            set tokenValue [lindex $t 0]
	    set tokenName [lindex $t 3]
	    if {$state == "search_guard"} {
		if {$tokenName != "space" && $tokenName != "newline" && $tokenName != "ccomment" && $tokenName != "cppcomment" && $tokenName != "pp_ifndef" && $tokenName != "identifier"} {
		    report $f 1 "Header file does not contain include guard"
		}
		if {$tokenName == "identifier"} {
		    set lastSlash [string last "/" $f]
		    if {$lastSlash != -1} {
                        set fileNameWOPath [string range $f [expr {$lastSlash + 1}] end]
		    } else {
			set fileNameWOPath $f
		    }
		    set expected_guard ""
		    append expected_guard [string map {. _} [string toupper $fileNameWOPath]] "_INCLUDED"
		    if {$tokenValue != $expected_guard} {
                        report $f 1 "Header file appears to have an include guard that does not match the codingguidelines. Expected \"$expected_guard\", got \"$tokenValue\""
		    }
		    set state "finished"
		}
	    }
	}
    } else {
        # ignore all other non-header files
    }
}
