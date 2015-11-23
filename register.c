#include "register.h"
#include <stdio.h>
#include <stdlib.h>

int reg_status[16] = {1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0};

const char *register_name(int r) {
	switch(r) {
		case 0:
			return "rax";
		case 1:
			return "rbx";
		case 2:
			return "rcx";
		case 3:
			return "rdx";
		case 4:
			return "rsi";
		case 5:
			return "rdi";
		case 6:
			return "rbp";
		case 7:
			return "rsp";
		case 8:
			return "r8";
		case 9:
			return "r9";
		case 10:
			return "r10";
		case 11:
			return "r11";
		case 12:
			return "r12";
		case 13:
			return "r13";
		case 14:
			return "r14";
		case 15:
			return "r15";
		default:
			fprintf(stderr, "the register number must be [0, 15]!\n");
			exit(EXIT_FAILURE);
	}
}

int register_alloc() {
	if(reg_status[1] == 0) {
		reg_status[1] = 1;
		return 1;
	} else {
		int i;
		for(i = 10; i <= 15; i ++) {
			if(reg_status[i] == 0) {
				reg_status[i] = 1;
				return i;
			}
		}
		fprintf(stderr, "there is no free register left!\n");
		exit(EXIT_FAILURE);
	}
}

void register_free(int r) {
	if(r < 0 || r > 15) {
		fprintf(stderr, "the register number must be [0, 15]!\n");
		exit(EXIT_FAILURE);
	}
	if(r == 1 || (r >= 10 && r <= 15)) { 
		reg_status[r] = 0;
	} else {
		fprintf(stderr, "the registers which can be freed are: rbx, r10 ~ r15!\n");
		exit(EXIT_FAILURE);
	}
}


