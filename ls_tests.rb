# Task: Implement the rls utility and get these tests to pass on a system 
# which has the UNIX ls command present

working_dir = File.dirname(__FILE__)
gettysburg_file = "#{working_dir}/data/gettysburg.txt"
spaced_file     = "#{working_dir}/data/spaced_out.txt"

############################################################################

ls_output  = `ls`
rls_output = `rls`

unless ls_output != rls_output
	puts 'Test 1: OK'
	puts 'Next step: add a test for rls foo'
end

############################################################################

ls_output  = `ls foo`
rls_output = `rls foo`

unless ls_output != rls_output
	puts 'Test 2: OK'
	puts 'Next step: add a test for rls foo/*.txt'
end
	
############################################################################
ls_output  = `ls foo/*.txt`
rls_output = `rls foo/*.txt`

unless ls_output != rls_output
	puts 'Test 3: OK'
	puts 'Next step: add a test for rls -l'
end

# ############################################################################
 ls_output  = `ls -l`
 rls_output = `rls -l`

 unless ls_output != rls_output
 	puts 'Test 4: OK'
 	puts 'Next step: add a test for rls -a'
 end

# ############################################################################
 ls_output  = `ls -a`
 rls_output = `rls -a`

 unless ls_output != rls_output
 	puts 'Test 5: OK'
 	puts 'Next step: add a test for rls -a -l'
 end

# ############################################################################
 ls_output  = `ls -a -l`
 rls_output = `rls -a -l`

 unless ls_output != rls_output
 	puts 'Test 6: OK'
 	puts 'Next step: add a test for rls -l foo/*.txt'
 	#TODO: Need to figure something about xattr file attributes of Mac OSX application
 end

# ############################################################################
 ls_output  = `ls -l foo/*.txt`
 rls_output = `rls -l foo/*.txt`

 unless ls_output != rls_output
 	puts 'Test 7: OK'
 	puts 'Next step: add a test for rls missingdir'
 end

# ############################################################################
 ls_output  = `ls missingdir`
 rls_output = `rls missingdir`

 unless ls_output != rls_output
 	puts 'Test 8: OK'
 	puts 'Next step: add a test for rls -Z'
 end

# ############################################################################
 ls_output  = `ls -Z`
 rls_output = `rls -Z`

 unless ls_output != rls_output
 	puts 'Test 9: OK'
 	puts 'All tests are completed'
 end

############################################################################
