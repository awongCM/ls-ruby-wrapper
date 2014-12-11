cat_output  = `cat #{gettysburg_file}`
rcat_output = `rcat #{gettysburg_file}`

fail "Failed 'cat == rcat'" unless cat_output == rcat_output

############################################################################

cat_output  = `cat #{gettysburg_file} #{spaced_file}`
rcat_output = `rcat #{gettysburg_file} #{spaced_file}`

fail "Failed 'cat [f1 f2] == rcat [f1 f2]'" unless cat_output == rcat_output

############################################################################

cat_output  = `cat < #{spaced_file}`
rcat_output = `rcat < #{spaced_file}`

fail "Failed 'cat < file == rcat < file" unless cat_output == rcat_output