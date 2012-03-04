<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title></title>
  </head>
  <body>
    {capture assign=headerStyle}colspan="2" style="text-align: left; padding: 4px; border-bottom: 1px solid #999; background-color: #eee;"{/capture}
    {capture assign=labelStyle }style="padding: 4px; border-bottom: 1px solid #999; background-color: #f7f7f7;"{/capture}
    {capture assign=valueStyle }style="padding: 4px; border-bottom: 1px solid #999;"{/capture}

    <p>Dear {contact.display_name},</p>
    <p>This is being sent to you as a receipt of payment.</p>

    <p>Your order number is #{$trxn->trxn_id}. Please print this confirmation for your records.{if $events_in_cart} Information about event registration will be sent separately to each participant.{/if}
      Here's a summary of your transaction placed on {$trxn->trxn_date|date_format:"%D %I:%M %p %Z"}:</p>
    
{if $billing_name}
	<table class="billing-info">
      <tr>
		<th style="text-align: left;">
		  {ts}Billing Name and Address{/ts}
		</th>
      </tr>
      <tr>
		<td>
		  {$billing_name}<br />
		  {$billing_street_address}<br />
		  {$billing_city}, {$billing_state} {$billing_postal_code}<br/>
		  <br/>
		  {$email}
		</td>
	  </tr>
    </table>
{/if}
{if $credit_card_type}
	<p>&nbsp;</p>
	<table class="billing-info">
      <tr>
		<th style="text-align: left;">
		  {ts}Credit Card Information{/ts}
		</th>
      </tr>
      <tr>
		<td>
		  {$credit_card_type}<br />
		  {$credit_card_number}<br />
		  {ts}Expires{/ts}: {$credit_card_exp_date.M}/{$credit_card_exp_date.Y}
		</td>
	  </tr>
    </table>
{/if}
{if $source}
    <p>&nbsp;</p>
    {$source}
{/if}
    <p>&nbsp;</p>
    <table width="600">
      <thead>
		<tr>
{if $line_items}
		  <th style="text-align: left;">
			Event
		  </th>
		  <th style="text-align: left;">
			Participants
		  </th>
{/if}
		  <th style="text-align: left;">
			Price
		  </th>
		  <th style="text-align: left;">
			Total
		  </th>
		</tr>
	  </thead>
      <tbody>
	{foreach from=$line_items item=line_item}
	<tr>
	  <td style="width: 220px">
	    {$line_item.event->title} ({$line_item.event->start_date|date_format:"%D"})<br />
	    {if $line_item.event->is_show_location}
	      {if $line_item.location.address.1.name}
		{$line_item.location.address.1.name}<br />
	      {/if}
	      {if $line_item.location.address.1.street_address}
		{$line_item.location.address.1.street_address}<br />
	      {/if}
	      {if $line_item.location.address.1.supplemental_address_1}
		{$line_item.location.address.1.supplemental_address_1}<br />
	      {/if}
	      {if $line_item.location.address.1.supplemental_address_2}
		{$line_item.location.address.1.supplemental_address_2}<br />
	      {/if}
	      {if $line_item.location.address.1.city}
		{$line_item.location.address.1.city}, {$location.address.1.state_province} {$location.address.1.postal_code}
	      {/if}
	    {/if}{*End of isShowLocation condition*}<br /><br />
	    {$line_item.event->start_date|date_format:"%D %I:%M %p"} - {$line_item.event->end_date|date_format:"%I:%M %p"}
	  </td>
	  <td style="width: 180px">
		{$line_item.num_participants}
	    {if $line_item.num_participants > 0}
	    <div class="participants" style="padding-left: 10px;">
	      {foreach from=$line_item.participants item=participant}
	      {$participant->first_name} {$participant->last_name}<br />
	      {/foreach}
	    </div>
	    {/if}
	    {if $line_item.num_waiting_participants > 0}
	    Waitlisted:<br/>
	    <div class="participants" style="padding-left: 10px;">
	      {foreach from=$line_item.waiting_participants item=participant}
	      {$participant->first_name} {$participant->last_name}<br />
	      {/foreach}
	    </div>
	    {/if}
	  </td>
	  <td style="width: 100px">
	    {$line_item.cost|crmMoney:$currency|string_format:"%10s"}
	  </td>
	  <td style="width: 100px">
	    &nbsp;{$line_item.amount|crmMoney:$currency|string_format:"%10s"}
	  </td>
	</tr>
	{/foreach}
      </tbody>
      <tfoot>
	{if $discounts}
	<tr>
	  <td>
	  </td>
	  <td>
	  </td>
	  <td>
	    Subtotal:
	  </td>
	  <td>
	    &nbsp;{$sub_total|crmMoney:$currency|string_format:"%10s"}
	  </td>
	</tr>
	{foreach from=$discounts key=myId item=i}
	<tr>
	  <td>
	    {$i.title}
	  </td>
	  <td>
	  </td>
	  <td>
	  </td>
	  <td>
	    -{$i.amount}
	  </td>
	</tr>
	{/foreach}
	{/if}
	<tr>
{if $line_items}
	  <td>
	  </td>
	  <td>
	  </td>
{/if}
	  <td>
	    <strong>Total:</strong>
	  </td>
	  <td>
	    <strong>&nbsp;{$total|crmMoney:$currency|string_format:"%10s"}</strong>
	  </td>
	</tr>
      </tfoot>
    </table>
  </body>
</html>
