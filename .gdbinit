# Turn off display "paging".
set height 0
set history filename ~/.gdb_history
set history save
set pagination off
set logging file /dev/null
# set height unlimited

# set prompt \033[0;32m(gdb) \033[0m

define nasm-assemble
 # dont enter routine again if user hits enter
 dont-repeat
 if ($argc)
  if (*$arg0 = *$arg0)
    # check if we have a valid address by dereferencing it,
    # if we havnt, this will cause the routine to exit.
  end
  printf "Instructions will be written to %#x.\n", $arg0
 else
  printf "Instructions will be written to stdout.\n"
 end
 printf "Type instructions, one per line.\n"
 printf "End with a line saying just \"end\".\n"
 if ($argc)
  # argument specified, wassemble instructions into memory
  # at address specified.
  shell cat > .gdbtmp.S \
    <<< "$( echo "BITS 32"; while read -ep '>' r && test "$r" != end; \
                do echo -E "$r"; done )"
  shell nasm -f bin -o .gdbtmp.bin .gdbtmp.S
  shell hexdump .gdbtmp.bin -ve \
        '1/1 "set *((unsigned char *) $arg0 + %#2_ax) = %#02x\n"' \
            > ~/.gdbassemble
  # load the file containing set instructions
  source ~/.gdbassemble
  # all done.
  # shell rm -f ~/.gdbassemble
 else
  # no argument, assemble instructions to stdout
  shell nasm -f bin -o /dev/stdout /dev/stdin \
    <<< "$( echo "BITS 32"; while read -ep '>' r && test "$r" != end; \
                do echo -E "$r"; done )" | ndisasm -i -b32 /dev/stdin
 end
end
document nasm-assemble
Assemble instructions using nasm.
Type a line containing "end" to indicate the end.
If an address is specified, insert instructions at that address.
If no address is specified, assembled instructions are printed to 
stdout.
Use the pseudo instruction "org ADDR" to set the base address.
end

define gas-assemble
 # dont enter routine again if user hits enter
 dont-repeat
 if ($argc)
  if (*$arg0 = *$arg0 )
    # check if we have a valid address by dereferencing it,
    # if we havnt, this will cause the routine to exit.
  end
  printf "Instructions will be written to %#x.\n", $arg0
 else
  printf "Instructions will be written to stdout.\n"
 end
 printf "Type instructions, one per line.\n"
 printf "End with a line saying just \"end\".\n"
 if ( $argc )
   # argument specified, assemble instructions into memory
   # at address specified.
   shell cat > .gdbtmp.S \
    <<< "$( echo ".code32"; echo ".global _start"; \
	while read -ep '>' r && test "$r" != end; \
                do echo -E "$r"; done )"
   shell as -o .gdbtmp.o .gdbtmp.S
   shell ld --oformat=binary -o .gdbtmp.bin .gdbtmp.o
   shell hexdump .gdbtmp.bin -ve \
        '1/1 "set *((unsigned char *) $arg0 + %#2_ax) = %#02x\n"' \
            > ~/.gdbassemble
   # load the file containing set instructions
   source ~/.gdbassemble
   # all done.
   #shell rm -f ~/.gdbassemble
 else
   # no argument, assemble instructions to stdout
   shell cat > .gdbtmp.S \
    <<< "$( echo ".code32"; echo ".global _start"; \
	while read -ep '>' r && test "$r" != end; \
                do echo -E "$r"; done )" 
   shell as -o .gdbtmp.o .gdbtmp.S
   shell ld --oformat=binary -o .gdbtmp.bin .gdbtmp.o
   # here we run it through intel2gas, since ndisasm is the only disassembler
   # I know of that produces the kind of output we want - but we want AT&T,
   # not intel
   shell objdump --prefix-addresses -D .gdbtmp.o | grep -v Disassembly | grep -v gdbtmp.o | grep -v "^ *$"
 end
end
document gas-assemble
Assemble instructions using gnu as.
Type a line containing "end" to indicate the end.
If an address is specified, insert instructions at that address.
If no address is specified, assembled instructions are printed to 
stdout.
end

define assemble
 # dont enter routine again if user hits enter
 dont-repeat
 if ($argc)
  if (*$arg0 = *$arg0)
    # check if we have a valid address by dereferencing it,
    # if we havnt, this will cause the routine to exit.
  end
  printf "Instructions will be written to %#x.\n", $arg0
 else
  printf "Instructions will be written to stdout.\n"
 end
 printf "Type instructions, one per line.\n"
 printf "End with a line saying just \"end\".\n"
 if ($argc)
  # argument specified, assemble instructions into memory
  # at address specified.
  shell nasm -f bin -o /dev/stdout /dev/stdin \
    <<< "$( echo "BITS 32"; while read -ep '>' r && test "$r" != end; \
                do echo -E "$r"; done )" | hexdump -ve \
        '1/1 "set *((unsigned char *) $arg0 + %#2_ax) = %#02x\n"' \
            > ~/.gdbassemble
  # load the file containing set instructions
  source ~/.gdbassemble
  # all done.
  shell rm -f ~/.gdbassemble
 else
  # no argument, assemble instructions to stdout
  shell nasm -f bin -o /dev/stdout /dev/stdin \
    <<< "$( echo "BITS 32"; while read -ep '>' r && test "$r" != end; \
                do echo -E "$r"; done )" | ndisasm -i -b32 /dev/stdin
 end
end
document assemble
Assemble instructions using nasm.
Type a line containing "end" to indicate the end.
If an address is specified, insert instructions at that address.
If no address is specified, assembled instructions are printed to stdout.
Use the pseudo instruction "org ADDR" to set the base address.
end

define hook-quit
  set confirm off
  if ($TMUX_CLEANUP)
    shell tmux kill-window
  else
  end
end
