ad_library {

        Automated tests for the dotlrn-bm package.

        @author Héctor Romojaro <hector.romojaro@gmail.com>
        @creation-date 2019-09-10

}

aa_register_case \
    -cats {api smoke production_safe} \
    -procs {
        dotlrn_bm::package_key
        dotlrn_bm::my_package_key
        dotlrn_bm::applet_key
    } \
    dotlrn_bm__keys {

        Simple test for the various dotlrn_bm::..._key procs.

        @author Héctor Romojaro <hector.romojaro@gmail.com>
        @creation-date 2019-09-10
} {
    aa_equals "Package key" "[dotlrn_bm::package_key]" "bulk-mail"
    aa_equals "My Package key" "[dotlrn_bm::my_package_key]" "dotlrn-bm"
    aa_equals "Applet key" "[dotlrn_bm::applet_key]" "dotlrn_bm"
}

aa_register_case -procs {
        dotlrn_bm::get_pretty_name
    } -cats {
        api
        production_safe
    } dotlrn_bm__names {
        Test diverse name procs.
} {
    aa_equals "Pretty name" "[dotlrn_bm::get_pretty_name]" "#bulk-mail.pretty_name#"
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
