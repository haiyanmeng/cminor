make
./valgrind_codegen >out_codegen 2>&1
grep -rna -e "ERROR SUMMARY" -e "exit code" out_codegen
grep -rna -E "definitely lost|indirectly lost|possibly lost|still reachable|suppressed" out_codegen

make
./valgrind_print >out_print 2>&1
grep -rna -e "ERROR SUMMARY" -e "exit code" out_print
grep -rna -E "definitely lost|indirectly lost|possibly lost|still reachable|suppressed" out_print

make
./valgrind_parse >out_parse 2>&1
grep -rna -e "ERROR SUMMARY" -e "exit code" out_parse
grep -rna -E "definitely lost|indirectly lost|possibly lost|still reachable|suppressed" out_parse

make
./valgrind_resolve >out_resolve 2>&1
grep -rna -e "ERROR SUMMARY" -e "exit code" out_resolve
grep -rna -E "definitely lost|indirectly lost|possibly lost|still reachable|suppressed" out_resolve

make
./valgrind_typecheck >out_typecheck 2>&1
grep -rna -e "ERROR SUMMARY" -e "exit code" out_typecheck
grep -rna -E "definitely lost|indirectly lost|possibly lost|still reachable|suppressed" out_typecheck

