ad_page_contract {

    @author yon (yon@openforce.net)
    @creation-date 2002-05-13
    @version $Id$

} -query {
    {orderby "send_date*,subject"}
} -properties {
    title:onevalue
    context_bar:onevalue
    table:onevalue
}

set package_id [ad_conn package_id]

set title [bulk_mail::pretty_name]
set context_bar {All}

set table_def {
    {send_date {Send Date} {bulk_mail_messages.send_date $order} {<td width="10%">[lc_time_fmt $send_date "%q"]</td>}}
    {from_addr From {bulk_mail_messages.from_addr $order} {<td width="15%">$from_addr</td>}}
    {subject Subject {bulk_mail_messages.subject $order} {<td><a href="[lindex [site_node::get_url_from_object_id -object_id $package_id] 0]one?bulk_mail_id=$bulk_mail_id">$subject</a></td>}}
    {sent_p {Sent?} {bulk_mail_messages.sent_p $order} {<td width="10%" align="center">[ad_decode $sent_p t Yes No]</td>}}
}

set sql "
    select bulk_mail_messages.*
    from bulk_mail_messages
    [ad_order_by_from_sort_spec $orderby $table_def]
"

set table [ad_table \
    -Tmissing_text {<blockquote><i>No bulk mail messages to display.</i></blockquote>} \
    -Torderby $orderby \
    -Ttable_extra_html {width="95%"} \
    select_bulk_mail_messages \
    $sql \
    $table_def \
]

ad_return_template
