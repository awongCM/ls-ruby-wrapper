# Task: Implement the ruby-ls utility and get these tests to pass on a system 
# which has the UNIX ls command present

working_dir = File.dirname(__FILE__)
gettysburg_file = "#{working_dir}/data/gettysburg.txt"
spaced_file     = "#{working_dir}/data/spaced_out.txt"

############################################################################

ls_output  = `ls`
rls_output = `ruby-ls`

fail "Failed 'cat == rcat'" unless cat_output == rcat_output

unless ls_output != rls_output
	puts 'Test 1: OK'
	puts 'Next step: add a test for ruby-ls foo/*.txt'
end

############################################################################



############################################################################
