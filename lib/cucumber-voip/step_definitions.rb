Given /^a caller ID of '([\w\d\s\.\:\@]+)'$/ do |caller_id|
  @outbound_caller_id = caller_id
end

Given /^my standard caller ID$/ do
  @outbound_caller_id = standard_caller_id
end

When /^I dial my app$/ do
  @call = dial :from => @outbound_caller_id, :to => standard_dial_target
end

When /^I dial '([\w\d\s\.\:\@]+)'$/ do |target_address|
  @call = dial :from => @outbound_caller_id, :to => target_address
end

Then /^the call should ring$/ do
  @call.next_event.should be_a_valid_ringing_event
end

Then /^the call should be answered$/ do
  @call.next_event.should be_a_valid_answered_event
end

Then /^the call should be hung up$/ do
  @call.next_event.should be_a_valid_hangup_event
end

Then /^the call should be rejected$/ do
  @call.next_event.should be_a_valid_reject_event
end

When /^I hang up$/ do
  @call.hangup.should have_executed_correctly
end

When /^I say '([\w\s]+)'$/ do |phrase|
  component = @call.say(:text => phrase).should have_executed_correctly
  component.next_event.should be_a_valid_say_event
end

When /^I press '([\d\*\#])'$/ do |digit|
  component = @call.output(:ssml => dtmf_ssml(digit)).should have_executed_correctly
  component.next_event.should be_a_valid_output_event
end
