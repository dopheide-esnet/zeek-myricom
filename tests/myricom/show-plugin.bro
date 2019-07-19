# @TEST-EXEC: zeek -NN Bro::Myricom |sed -e 's/version.*)/version)/g' >output
# @TEST-EXEC: btest-diff output
