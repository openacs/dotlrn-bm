#
#  Copyright (C) 2001, 2002 OpenForce, Inc.
#
#  This file is part of dotLRN.
#
#  dotLRN is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#
#  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#

ad_library {

    proc library for dotlrn bulk-mail applet

    @author yon (yon@openforce.net)
    @creation-date 2002-05-13
    @version $Id$

}

namespace eval dotlrn_bm {

    ad_proc -public applet_key {
    } {
        get the applet_key
    } {
        return "dotlrn_bm"
    }

    ad_proc -public package_key {
    } {
        get the package_key this applet deals with
    } {
        return "bulk-mail"
    }

    ad_proc portal_element_key {
    } {
        return the portal element key
    } {
        return "bm-portlet"
    }

    ad_proc -public get_pretty_name {
    } {
        returns the pretty name
    } {
        return "dotLRN Bulk Mail Applet"
    }

    ad_proc -public get_user_default_page {} {
        return the user default page to add the portlet to
    } {
        return ""
    }

    ad_proc -public get_community_default_page {} {
        return the user default page to add the portlet to
    } {
        return ""
    }

    ad_proc -public get_subcomm_default_page {} {
        return the user default page to add the portlet to
    } {
        return ""
    }

    ad_proc -public add_applet {
    } {
        used for one-time init - must be repeatable!
    } {
        if {![dotlrn::is_package_mounted -package_key [package_key]]} {
            set package_id [dotlrn::mount_package \
                -package_key [package_key] \
                -url [package_key] \
                -directory_p "t"]

            portal::mapping::new \
                -object_id $package_id \
                -node_id [site_nodes::get_node_id_from_package_id -package_id $package_id]

            dotlrn_applet::add_applet_to_dotlrn -applet_key [applet_key]

            dotlrn_applet::mount -package_key "dotlrn-bm" -url "bm" -pretty_name "Bulk Mail"
        }
    }

    ad_proc -public remove_applet {
    } {
        remove the applet from dotlrn
    } {
    }

    ad_proc -public add_applet_to_community {
        community_id
    } {
        Add the bulk-mail applet to a dotlrn community
    } {
        if {[dotlrn_community::dummy_comm_p -community_id $community_id]} {
            return
        }

        set portal_id [dotlrn_community::get_admin_portal_id -community_id $community_id]
        set package_id [dotlrn::instantiate_and_mount $community_id [package_key]]

        bm_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id

        return $package_id
    }

    ad_proc -public remove_applet_from_community {
        community_id
    } {
        remove the bulk-mail applet from a dotlrn community
    } {
        set portal_id [dotlrn_community::get_admin_portal_id -community_id $community_id]
        set package_id [dotlrn::get_community_applet_package_id \
            -community_id $community_id \
            -package_key [package_key]
        ]

        bm_portlet::remove_self_from_page -portal_id $portal_id -package_id $package_id
    }

    ad_proc -public add_user {
        user_id
    } {
        one time user-specfic init
    } {
    }

    ad_proc -public remove_user {
        user_id
    } {
        one time user-specific removal
    } {
    }

    ad_proc -public add_user_to_community {
        community_id
        user_id
    } {
        add a user to a community
    } {
    }

    ad_proc -public remove_user_from_community {
        community_id
        user_id
    } {
        remove a user from a community
    } {
    }

    ad_proc -public add_portlet {
        portal_id
        args
    } {
        a helper proc to add the underlying portlet to the given portal.
    } {
        ns_log notice "** Error in [get_pretty_name]: 'add_portlet' not implemented!"
        ad_return_complaint 1 "Please notifiy the administrator of this error: ** Error in [get_pretty_name]: 'add_portlet' not implemented!"
    }

    ad_proc -public remove_portlet {
        portal_id
        args
    } {
        a helper proc to remove the underlying portlet from the given portal.
    } {
        ns_log notice "** Error in [get_pretty_name]: 'remove_portlet' not implemented!"
        ad_return_complaint 1 "Please notifiy the administrator of this error: ** Error in [get_pretty_name]: 'remove_portlet' not implemented!"
    }

    ad_proc -public clone {
        old_community_id
        new_community_id
    } {
        clone this applet's content from the old community to the new one
    } {
        ns_log notice "** Error in [get_pretty_name] 'clone' not implemented!"
        ad_return_complaint 1 "Please notifiy the administrator of this error: ** Error in [get_pretty_name]: 'clone' not implemented!"
    }

    ad_proc -public get_package_id {
    } {
        returns the package_id of the dotlrn-bm package
    } {
        return [db_string select_package_id {
            select min(package_id)
            from apm_packages
            where package_key = 'dotlrn-bm'
        }]
    }

    ad_proc -public get_url {
    } {
        returns the URL for the dotlrn-bm package
    } {
        return [site_nodes::get_url_from_package_id -package_id [get_package_id]]
    }

}
