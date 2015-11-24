section .rodata
.str0
.string "h\t\n"
.string "\\ello"
.string "haiyan"
.text
lea .str0, %rbx
section .rodata
.str1
.string "hello\t\\\n"
.string "world"
.text
lea .str1, %rbx
section .rodata
.str2
.string "haiyan\tmeng\\gezi\npeng"
.string "end"
.text
lea .str2, %rbx
section .rodata
.str3
.string "h\t\n\\ello"
.string ""
.text
lea .str3, %rbx
mov $92, %rbx
mov $9, %rbx
movq $1, %rbx
movq $0, %rbx
